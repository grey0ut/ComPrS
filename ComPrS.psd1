@{
RootModule = 'ComPS.psm1'
ModuleVersion = '0.1.0'
CompatiblePSEditions = @("Desktop","Core")
GUID = '83c66aab-526a-4f3b-a8f2-e84e22fa0cf9'
Author = 'Courtney Bodett'
CompanyName = 'Grey0ut'
Copyright = '(c) 2025 Courtney Bodett. All rights reserved.'
Description = 'Compress string text'
PowerShellVersion = '5.1'
FunctionsToExport = 'Compress-String', 'Expand-String'
CmdletsToExport = '*'
VariablesToExport = '*'
AliasesToExport = '*'
PrivateData = @{
    PSData = @{
        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('string','compress','compression','expand','deflate','brotli')
        # A URL to the license for this module.
        LicenseUri = 'https://github.com/grey0ut/ComPrS/blob/main/LICENSE'
        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/grey0ut/ComPrS'
        # A URL to an icon representing this module.
        # IconUri = ''
        # ReleaseNotes of this module
        # ReleaseNotes = ''
    } # End of PSData hashtable
} # End of PrivateData hashtable
}
