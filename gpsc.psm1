function Get-StartDate {
	param (
		[Switch] $NoNewline
	)
	if ( $NoNewline ) {
		Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkGreen
	}
	else {
		Write-Host (Get-Date -Format G) -ForegroundColor DarkGreen
	}
}
function gpsc {
	param (
		[double] $Count,
		[string[]] $Name = '*',
		[Switch] $NoDate
	)
	if ( !$NoDate ) {
		Get-StartDate -NoNewline
	}
	$pn = Get-Process
	if ( !$Count ) {
		$un = switch ( $pn ) {
			default {
				if ( $_.ProcessName -eq "NortonSecurity" -and $_.SI -ne 0 ) { $_ }
			}
		}
		$c = $un.CPU - 1.0
		$Count = [System.Math]::Min(([System.Math]::Max($c, 0.8)), 23)
	}
	$u = switch ( $pn ) {
		default {
			if ( $_.ProcessName -like $Name -and $_.CPU -ge $Count ) { $_ }
		}
	}
	$u | Sort-Object CPU -Descending
}
