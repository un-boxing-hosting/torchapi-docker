#! /bin/sh
# VARIABLES

export WINEARCH=win64
export WINEPREFIX=/wineprefix
export DISPLAY=":99"

echo "----------------------------- INIT SERVER ---------------------------"

if [ ! -f /app/.Xauthority ]; then
  runuser -u wine -- touch /app/x11vnc.log /app/.Xauthority
fi
runuser -u wine -- bash -c 'Xvfb :99 -screen 0 1024x768x24 -ac -br -auth /app/.Xauthority &'
runuser -u wine -- bash -c 'x11vnc -display WAIT:99 -forever -autoport 5900 -auth /app/.Xauthority -passwd BoxingHosting! -o /app/x11vnc.log -bg &'
  
echo "Waiting 5 seconds for X server to initialize..."
sleep 5
  
runuser -u wine -- bash -c 'DISPLAY=:99 openbox &'
echo "Openbox started." 

# Open up file browser
runuser -u wine -- bash -c 'DISPLAY=":99" winefile &'
echo "Winefile started in VNC WM"

# Run Torch Server
echo "Starting Torch Server ..."
runuser -u wine -- bash -c 'DISPLAY=":99" wine Z:/app/torch-server/Torch.Server.exe'
#xvfb-run -n 99 -l -f /app/.Xauthority -- wine torch-server/Torch.Server.exe $@ &

echo "Something didn't work.  Break this."


