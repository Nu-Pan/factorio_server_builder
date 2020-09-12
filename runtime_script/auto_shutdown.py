import factorio_rcon
import argparse
import time
import re

# config
ENABLE_LOG_DEBUG = True
SHUTDOWN_PENDING_TIME_IN_SEC = 60 * 3
PERIOD_IN_SEC = 60

def logDebug(*args):
    '''
    Log printer for debug.
    '''
    if not ENABLE_LOG_DEBUG:
        return
    print(args)

if __name__ == "__main__":
    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, required=True, help="RCON port number")
    parser.add_argument("--password", type=str, required=True, help="RCON password")
    args = parser.parse_args()
    # Create RCON client
    client = factorio_rcon.RCONClient("localhost", args.port, args.password )
    # initialize latest alive time
    latest_alive_time_in_sec = time.time()
    # main loop
    while True:
        # get current time
        current_time_sec = time.time()
        # get online player count
        response = client.send_command("/players online count")
        m = re.match(r'Online players \((\d+)\)', response)
        if m is None:
            print("/players command response isn't matched")
            print("for safe, send /quit message")
            client.send_command("/quit")
            break
        player_count = int(m.group(1))
        # Update latest alive time
        if player_count > 0:
            latest_alive_time_in_sec = current_time_sec
        # If meet the condition, sen /quit command to RCON server
        if (current_time_sec - latest_alive_time_in_sec) > SHUTDOWN_PENDING_TIME_IN_SEC:
            client.send_command("/quit")
            break
        # to next
        logDebug("player_count = %d" % player_count)
        logDebug("elapsed since latest online = %d" % (current_time_sec - latest_alive_time_in_sec))
        time.sleep(PERIOD_IN_SEC)
    # normaly finished
    exit(0)
