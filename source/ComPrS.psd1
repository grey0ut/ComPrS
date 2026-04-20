@{

# Script module or binary module file associated with this manifest.
RootModule = 'ComPrS.psm1'

# Version number of this module.
ModuleVersion = '0.1.2'

# Supported PSEditions
CompatiblePSEditions = 'Desktop', 'Core'

# ID used to uniquely identify this module
GUID = '83c66aab-526a-4f3b-a8f2-e84e22fa0cf9'

# Author of this module
Author = 'Courtney Bodett'

# Company or vendor of this module
CompanyName = 'Grey0ut'

# Copyright statement for this module
Copyright = '(c) 2025 Courtney Bodett. All rights reserved.'

# Description of the functionality provided by this module
Description = 'Compress string text'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Compress-String', 'Expand-String', 'ConvertTo-HereString'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()
# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = @()


# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'string','compress','compression','expand','deflate','brotli'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/grey0ut/ComPrS/blob/main/LICENSE'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/grey0ut/ComPrS'

        # ReleaseNotes of this module
        ReleaseNotes = ''

    } # End of PSData hashtable

 } # End of PrivateData hashtable

}