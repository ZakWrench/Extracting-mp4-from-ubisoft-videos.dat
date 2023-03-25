<#
1- Open videos.dat file in a hex editor(HxD)
2- look up moOV value, save its offset
3- look up the second ftyp, and save its offset
moOV is the metadata of the video, ftyp means mp4

PowerShell script:
#>
$offset = "replace with moOV hex value"
$length = "replace with second ftyp hex value"
$sourceFile = "C:\\path\\to\\videos.dat"
$destinationFile = "C:\\path\\to\\video_output.mp4"

$bufferSize = 8192
$bytesRemaining = $length

$sourceStream = New-Object -TypeName System.IO.FileStream -ArgumentList $sourceFile, 'Open', 'Read'
$destinationStream = New-Object -TypeName System.IO.FileStream -ArgumentList $destinationFile, 'Create', 'Write'

$sourceStream.Position = $offset

while ($bytesRemaining -gt 0) {
    $bytesToRead = [System.Math]::Min($bufferSize, $bytesRemaining)
    $buffer = New-Object -TypeName Byte[] -ArgumentList $bytesToRead
    $bytesRead = $sourceStream.Read($buffer, 0, $bytesToRead)
    $destinationStream.Write($buffer, 0, $bytesRead)
    $bytesRemaining -= $bytesRead
}

$sourceStream.Close()
$destinationStream.Close()
