function Write-LNSMessage {
    <#
    .SYNOPSIS
        Writes a message to log file and the screen

    .DESCRIPTION
        this will write a message to a log file and the screen if interactive.
        the message will be prefixed with the date and time along with the status based on the parameters passed.
        This will also determine the color output of the message to the screen.
        The log file will always be created in the user's temp folder.

    .EXAMPLE

#>

    [CmdLetBinding()]
    param(
        # This parameter will create a new file if supplied
        # overwriting the existing file if it exists
        [switch]
        $NewFile,

        # The message to be written to the log
        [Parameter(Mandatory = $true)]
        [string]
        $Message,

        # The name of the log file
        [string]
        $LogFileName,

        # The status of the message
        [Parameter(Mandatory = $true)]
        [ValidateSet("INFORMATION", "WARNING", "ERROR", "DEBUG", "VERBOSE")]
        [string]
        $Level

    )

    begin {

        # Get date and time in dd/mm/yyy HH:mi format
        # Set the output message to be dat/time - Message
        $Date = Get-Date -Format g
        $Message = $Date + "-" + $Message

        # Check if the file exists
        $Folder = "C:\Users\$env:USERNAME\AppData\Local\Temp"
        if (!(Testpath $folder)) {
            [void](New-item -Path $Folder -ItemType Directory -Force)
        }

    }
    process {

        $LogFile = $Folder + "\" + $LogFileName
        If (!($Logfile -or $NewFile)) {
            $Stream = New-Object System.IO.StreamWriter $LogFile
            $Stream.WriteLine($Message)
        }
        Else {
            $Stream = New-Object System.IO.StreamWriter($LogFile, $True)
            $Stream.WriteLine($Message)
        }

        $Stream.Close()

        # Write the message out to the screen depending on level
        # DEBUG and VERBOSE will on print out if call function with those flags, default is SilentyContine
        switch ($Level) {

            "INFORMATION" { Write-Information -MessageData $Message -InformationAction Continue }
            "WARNING" { Write-Warning -Message $Message }
            "ERROR" { Write-Error -Message $Message }
            "DEBUG" { Write-Debug -Message $Message }
            "VERBOSE" { Write-Verbose -Message $Message }
        }

    }
    end {

    }

    
}