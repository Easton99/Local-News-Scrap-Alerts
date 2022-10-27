function Get-LNSLocation {
    <#
    .SYNOPSIS
        Short description

    .DESCRIPTION
        Long description

    .EXAMPLE
        Example can be supplied multiple times to show different example cases

#>

    [CmdLetBinding()]
    param(

    )

    begin {

    }
    process {
        Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace
        $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
        $GeoWatcher.Start() #Begin resolving current locaton

        while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
            Start-Sleep -Milliseconds 100 #Wait for discovery.
        }  

        if ($GeoWatcher.Permission -eq 'Denied') {
            Write-Error 'Access Denied for Location Information'
        }
        else {
            $GeoWatcher.Position.Location | Select-Object Latitude, Longitude #Select the relevent results.
        }

    }
    end {

    }

    
}