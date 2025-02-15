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
    #>
    [Cmdletbinding()]
    Param (
        [Parameter(ValueFromPipeline)]
        [String[]]$String,
        [ValidateSet('Deflate','Brotli')]
        [String]$Algorithm = $(Set-CompressionAlgorithm)
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
    }

    process {
        foreach ($InputString in $String) {
            try {
                $StreamWriter.Write($InputString)
                $StringLength += $InputString.Length
            } catch {
                Write-Error $_
            }
        }
    }

    end {
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
