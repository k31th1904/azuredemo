# Enable FSLogix
REG ADD "HKLM\Software\FSLogix\Profiles" /v "Enabled" /t REG_DWORD /d 1 /f

# Define VHDLocation for Roaming Profile in Azure
REG ADD "HKLM\Software\FSLogix\Profiles" /v "VHDLocations" /t REG_SZ /d "\\fslogixavddemo.file.core.windows.net\fslogixprofiles" /f

# Define Volume type
REG ADD "HKLM\Software\FSLogix\Profiles" /v "VolumeType" /t REG_SZ /d "vhdx" /f

# DeleteLocalProfileWhenVHDShouldApply
REG ADD "HKLM\Software\FSLogix\Profiles" /v "DeleteLocalProfileWhenVHDShouldApply" /t REG_DWORD /d 1 /f

# Use FlipFlopProfileDirectoryName
REG ADD "HKLM\Software\FSLogix\Profiles" /v "FlipFlopProfileDirectoryName" /t REG_DWORD /d 1 /f
