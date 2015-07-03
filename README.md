# Battery-Checker-Script-for-mint-ubuntu
A Battery Monitor script for mint/ubuntu os. Once started it polls for every 5 minutes. It Checks Battery percentage. If it is less than 18% then prompts a low-battery-sound. ( You can modify chekpc parameter in the script to other than 18)

# Why This Script
I am user of mint os (Cinnamon). It do not produc any warning sound when battery is low.
It only shows a pop-up that battery is low and connect to power source
When I am reading some pdf or watching video fullscreen then I miss the pop-up and my machine goes to sleep mode.
SO to get rid of that issue I created this script. 
Hope you find this useful.

# Assumptions:
 + A Low-battery-sound.mp3 is present in /usr/share/sounds/ folder
   + You can download it from http://www.orangefreesounds.com/wp-content/uploads/Zip/Low-battery-sound.zip 
   + Extract the .mp3 file and place it in /usr/share/sounds/ folder
 + `alsamixer` command is supported (i.e. your PC is having ALSA sound card)
   + install it using 
    + `sudo apt-get install alsa`
 + `play` command installed and can play .mp3 files
    + if not installed then install it using
      + `sudo apt-get install sox`
    + add support for .mp3 format using:
      + `sudo apt-get install sox libsox-fmt-mp3`
    
# Get the script
` wget https://github.com/rameshgkwd05/Battery-Checker-Script-for-mint-ubuntu/blob/master/BatteryCheckerScript.sh`


# Usage
(Please Don't run it as background process by adding &)

`bash BatteryCheckerScript.sh`

or 

`chmod +x BatteryCheckerScript.sh`
`./BatteryCheckerScript.sh`

or (Best Option)
+ Just double click and set `Run software` as default option.

#Future Work
Adding it as a service to /etc/init.d. So that it can be started with system boot.
