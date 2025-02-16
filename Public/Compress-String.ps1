function Compress-String {
    <#
    .SYNOPSIS
    Accepts string input, compresses it using the DEFLATE algorithm, and returns the bytes encoded in base64
    .DESCRIPTION
    Provides little benefit against short strings but could be useful for large string values, multi-line files, or script blocks.
    .PARAMETER String
    String input for compressing.  If multiple strings are passed through the pipeline they will be included in the compression together and output as a single base64 string.
    If piping file content from Get-Content make sure to use the -Raw parameter with Get-Content to avoid sending empty strings.
    .PARAMETER Algorithm
    Optionally specify a compression algorithm. Choices are DEFLATE or Brotli however Brotli is only available on PS Version 6.1 or newer. 
    .PARAMETER NoPreserve
    By default when given an array of strings Compress-String will attempt to preserve formatting by joining each string together before compressing it.
    This will bring over new line characters and blank lines so that when later expanded it will look the same.  If you'd prefer not to do that supply the -NoPreserve switch 
    and each string will be streamed in to the compression writer.
    #>
    [Cmdletbinding()]
    Param (
        [Parameter(ValueFromPipeline)]
        [String[]]$String,
        [ValidateSet('Deflate','Brotli')]
        [String]$Algorithm = $(Set-CompressionAlgorithm),
        [Switch]$NoPreserve
    )

    begin {
        if ($PSVersionTable.PSVersion -lt [Version]'6.1' -and $Algorithm -eq 'Brotli') {
            Write-Warning "PSVersion is <6.1. Brotli compression not available. Reverting to Deflate"
            $Algorithm = 'Deflate'
        } 
        
        Write-Verbose "Algorithm: $Algorithm" 
        $MemoryStream = [System.IO.MemoryStream]::new()
        $CompressionStream = switch ($Algorithm) {
            'Deflate' {
                [System.IO.Compression.DeflateStream]::new($MemoryStream, [System.IO.Compression.CompressionMode]::Compress)
            }
            'Brotli' {
                [System.IO.Compression.BrotliStream]::new($MemoryStream, [System.IO.Compression.BrotliCompressionOptions]@{Quality=11})
            }
        }
        $StreamWriter = [System.IO.StreamWriter]::new($CompressionStream)
        $StringLength = 0
        if ($MyInvocation.ExpectingInput) {
            $PipeLineStrings = [System.Collections.ArrayList]::new()
        }
    }
    # consider re-writing this so that all string objects are added together in to an array and the piped to Out-String.
    # this will convert it in to a herestring which will preserve CR so when it's later expanded it still looks like the original
    # https://communary.net/2015/01/12/quick-tip-determine-if-input-comes-from-the-pipeline-or-not/
    # $MyInvocation.ExpectingInput
    process {
        if ($NoPreserve) {
            foreach ($InputString in $String) {
                try {
                    $StreamWriter.Write($InputString)
                    $StringLength += $InputString.Length
                } catch {
                    Write-Error $_
                }
            }
        } else {
            if ($MyInvocation.ExpectingInput) {
                [Void]$PipeLineStrings.Add($String)
            } else {
                try {
                    $InputString = $String | Out-String
                    $StreamWriter.Write($InputString)
                    $StringLength += $InputString.Length
                } catch {
                    Write-Error $_
                }

            }
        }
        
    }

    end {
        if ($MyInvocation.ExpectingInput) {
            try {
                $InputString = $PipelineStrings | Out-String
                $StreamWriter.Write($InputString)
                $StringLength += $InputString.Length
            } catch {
                Write-Error $_
            }
        }
        try {
            $StreamWriter.Close()
            $Base64String = [System.Convert]::ToBase64String($MemoryStream.ToArray())
            $Base64String
        } catch {
            Write-Error $_
        }
        $MemoryStream.Dispose()
        Write-Verbose "Total string input length: $StringLength"
        Write-Verbose "Total string output length: $($Base64String.Length)"
    }
}
