$input = Get-Content -Path "D:\Workspace\Advent-of-Code-2019\day-01.input.txt"

# Start with fuel at zero
$fuelForMass = 0
$fuelForMassWithFuel = 0

# Walk trough all the mass
$input -split " " | ForEach-Object {
    $mass = [int]$_;

    # Calculate fuel for mass (with and without mass of fuel)
    $fuelForMass += calculateFuel -mass $mass -includeFuelMass $false
    $fuelForMassWithFuel += calculateFuel -mass $mass -includeFuelMass $true
}

Write-Host "Part 1: " $fuelForMass
Write-Host "Part 2: " $fuelForMassWithFuel


# Handle fuel calculation
function calculateFuel ($mass, $includeFuelMass) {
    $fuel = 0;

    # Only calculate fuel if mass is greater than zero
    if($mass -gt 0) {
        $fuel = [math]::floor($mass / 3) - 2

        # Don't use negative fuel result
        if($fuel -lt 0) {
            $fuel = 0;
        }
        
        # Calculate fuel for fuel mass if required
        if($includeFuelMass) {
            $fuel += calculateFuel $fuel $true;
        }
    }

    return $fuel
}
