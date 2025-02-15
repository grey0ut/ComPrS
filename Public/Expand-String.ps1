function Expand-String {
    <#
    .SYNOPSIS
    Accepts string input, expands it using the DEFLATE algorithm, and returns the bytes converted to string
    .DESCRIPTION
    For expanding the base64 encoded output from the Compress-String function.
    .PARAMETER String
    String input for expanding.  
    .PARAMETER Algorithm
    Optionally specify a compression algorithm. Choices are DEFLATE or Brotli however Brotli is only available on PS Version 6.1 or newer. 
    #>
    Param (
        [Parameter(Mandatory=$true)]
        [String]$String,
        [ValidateSet('Deflate','Brotli')]
        [String]$Algorithm = $(Set-CompressionAlgorithm)
    )

    if ($PSVersionTable.PSVersion -lt [Version]'6.1' -and $Algorithm -eq 'Brotli') {
        Write-Warning "PSVersion is <6.1. Brotli compression not available. Reverting to Deflate"
        $Algorithm = 'Deflate'
    }

    try {
        $Bytes = [System.Convert]::FromBase64String($String)
        $MemoryStream = [System.IO.MemoryStream]::new()
        $MemoryStream.Write($Bytes, 0, $Bytes.Length)
        [Void]$MemoryStream.Seek(0, 0)
        $DecompressionStream = switch ($Algorithm) {
            'Deflate' {
                [System.IO.Compression.DeflateStream]::new($MemoryStream, [System.IO.Compression.CompressionMode]::Decompress)
            }
            'Brotli' {
                [System.IO.Compression.BrotliStream]::new($MemoryStream, [System.IO.Compression.CompressionMode]::Decompress)
            }
        }
        $StreamReader = [System.IO.StreamReader]::new($DecompressionStream)
        $StreamReader.ReadToEnd()
    } catch {
        Write-Error $_
    }

    $MemoryStream.Dispose()
    $DecompressionStream.Dispose()
    $StreamReader.Dispose() 
}

