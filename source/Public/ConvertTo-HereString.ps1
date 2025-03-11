function ConvertTo-HereString {
    <#
    .SYNOPSIS
    Convert a long single string in to a multi line here-string.
    .DESCRIPTION
    When working with Compress-String the output can be very long depending on what you're compressing.  If you'd like to store this compressed string in a script it might look nicer
    if it ran vertically instead of just horizontally.  This function will turn a single tring in to a multi line here-string of a given width.
    .PARAMETER String
    The long string to convert in to a here string.
    .PARAMETER Width
    optionally specify the character width for the here string. Defaults to 160.
    #>
    [Cmdletbinding()]
    param (
        [String]$String,
        [Int64]$Width = 160
    )

    $Regex = [Regex]"(.{$Width})"

    $StringChunks = $String -split $Regex | Where-Object {$_}
    Write-Verbose "Original string length: $($String.Length)"
    Write-Verbose "Here-string lines: $($StringChunks.count)"
    $StringChunks | Out-String
}