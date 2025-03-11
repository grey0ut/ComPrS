function Set-CompressionAlgorithm {
    param ()

    # detect which version of Powershell, and therefore .NET, to set a default compression algorithm
    if ($PSVersionTable.PSVersion -lt [Version]'6.1') {
        return "Deflate"
    } else {
        return "Brotli"
    }
}