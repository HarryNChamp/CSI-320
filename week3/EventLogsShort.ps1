Function Get-LoginLogoutEvents {
    Param(
        [Parameter(Mandatory = $true)]
        [int]$Days = 14
    )

    # Initialize an empty array to store custom event objects
    $loginoutsTable = @()

    # Define the event IDs for logon and logoff events
    $eventIDs = @(4624, 4634)

    # Get the logon and logoff events from the Security log for the specified number of days
    $events = Get-EventLog -LogName Security -After (Get-Date).AddDays(-$Days) | Where-Object { $_.EventID -in $eventIDs }

    # Loop over each event and process it
    foreach ($event in $events) {
        # Determine the event type based on ID
        $eventType = switch ($event.EventID) {
            4624 { "Logon" }
            4634 { "Logoff" }
        }

        # Extract the User SID from event data
        $userSID = $event.ReplacementStrings[4]

        # Translate SID to username using System.Security.Principal.SecurityIdentifier
        $userName = try {
            $sid = New-Object System.Security.Principal.SecurityIdentifier($userSID)
            $user = $sid.Translate([System.Security.Principal.NTAccount])
            $user.Value
        } catch {
            "Unknown User"
        }

        # Create a new custom object with the specified properties
        $customEvent = [PSCustomObject]@{
            Time  = $event.TimeGenerated
            Id    = $event.InstanceId
            Event = $eventType
            User  = $userName
        }

        # Add the custom object to the array
        $loginoutsTable += $customEvent
    }

    # Return the table of results
    return $loginoutsTable
}

# Call the function with the default parameter (14 days) and print the results
$results = Get-LoginLogoutEvents -Days 14
$results

Function Get-StartupShutdownEvents {
    Param(
        [Parameter(Mandatory = $true)]
        [int]$Days = 14
    )

    # Initialize an empty array to store custom event objects
    $startupShutdownTable = @()

    # Define the event IDs for startup and shutdown events
    $eventIDs = @(6005, 6006)

    # Get the startup and shutdown events from the System log for the specified number of days
    $events = Get-EventLog -LogName System -After (Get-Date).AddDays(-$Days) | Where-Object { $_.EventID -in $eventIDs }

    # Loop over each event and process it
    foreach ($event in $events) {
        # Determine the event type based on ID
        $eventType = switch ($event.EventID) {
            6005 { "Startup" }
            6006 { "Shutdown" }
        }

        # Username will always be System
        $userName = "System"

        # Create a new custom object with the specified properties
        $customEvent = [PSCustomObject]@{
            Time  = $event.TimeGenerated
            Id    = $event.InstanceId
            Event = $eventType
            User  = $userName
        }

        # Add the custom object to the array
        $startupShutdownTable += $customEvent
    }

    # Return the table of results
    return $startupShutdownTable
}

# Call the function with the default parameter (14 days) and print the results
$results2 = Get-StartupShutdownEvents -Days 14
$results2