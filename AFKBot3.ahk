CoordMode, Pixel, Screen
SetKeyDelay, 20
detect = 0
JoinMsg = 0
TimeMsg = 0
NoPlayer = 0

Helm:
    Send, {Left}
    Sleep, 500
    Send, {F1}
    Sleep, 1000
    MouseMove, 1716, 48, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 1000
    MouseMove, 297, 779, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 1000
    MouseMove, 1480, 251, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 100
    run, f13.ahk, PATH\TO\keys
    Sleep, 200
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {Esc}
    Sleep, 500
    Send, {Left}
    Sleep, 500
    Send, M
    Sleep, 2000
    Send, D
    Sleep, 3000
    MouseMove, 1193, 158, 5
    Sleep, 500
    Send {LButton}
    Sleep, 1000
    MouseMove, 1227, 528, 5
    Sleep, 500
    Send {LButton}
    Sleep, 1000
    loop, 420 {
        ImageSearch, , , 1392, 148, 1873, 251, *10 PATH\TO\1.png
        if ErrorLevel = 1
            Goto, Welcome
        Sleep, 1000
    }
    NoPlayer := 1
    Goto, Welcome
Welcome:
    Sleep, 2000 
    Send, {Enter}
    Sleep, 200
    Send, Player detected, Welcome Guardian.
    Sleep, 200
    Send, {Enter}
    Sleep, 500
    Send, {Enter}
    Sleep, 200
    Send, Traveling to Golg Maze in 3 minutes.
    Sleep, 200
    Send, {Enter}
    Sleep, 200
    MouseMove, 1227, 528, 5
    Sleep, 200
    Send, {LButton}
    Sleep, 200
    Send, {LButton}
    Sleep, 1000
    If NoPlayer = 1
        run, SlotsEmpty.ahk
    If NoPlayer = 0
        run, Slots.ahk
class AnnounceCounter {
    __New() {
        this.interval := 30000
        this.count := 1
        this.timer := ObjBindMethod(this, "Tick")
    }
    Start() {
        this.count := 1
        run, f20.ahk, C:\Users\Bep\Desktop\Bot\keys
        timer := this.timer
        SetTimer % timer, % this.interval
    }
    Stop() {
        timer := this.timer
        SetTimer % timer, Delete
    }
    Tick() {
        TimeSpent := this.interval * this.count++
        RemainingSeconds := (180000 - TimeSpent) / 1000
        If RemainingSeconds = 0
            return
        RemainingMinutes := Floor(RemainingSeconds / 60)
        RemainingSeconds := Round(Mod(RemainingSeconds, 60))
        TimeStartTime := A_TickCount
        TimeMsg := 1
        If JoinMsg = 1
            Sleep, 2000

        If detect = 0
            Sendraw, =
            detect := 1

        Sleep, 100
        Send, {Enter}
        Sleep, 100
        If RemainingSeconds = 0
            if RemainingMinutes = 1
                Send, Traveling to Golg Maze in 1 minute.
            else
                Send, Traveling to Golg Maze in %RemainingMinutes% minutes.
        Else If RemainingMinutes = 0
            Send, Traveling to Golg Maze in %RemainingSeconds% seconds.
        Else
            Send, Traveling to Golg Maze in %RemainingMinutes%m %RemainingSeconds%s.
        Sleep, 200
        Send, {Enter}
        Sleep, 200
        MouseMove, 1227, 528, 5
        Sleep, 200
        Send, {LButton}
        Sleep, 200
        Send, {LButton}
        Sleep, 1000
        If detect = 1
            Sendraw, =
            detect := 0
        TimeMsg := 0
        TotalTime += (A_TickCount - TimeStartTime)
    }
}

counter := new AnnounceCounter
counter.Start()

loop, {
    JoinStartTime := A_TickCount
    ImageSearch, , , 1392, 572, 1873, 675, *10 PATH\TO\\5.png
    If ErrorLevel = 1
        {
        Sleep, 2000
        ImageSearch, , , 1392, 572, 1873, 675, *10 PATH\TO\\5.png
        If ErrorLevel = 1
            counter.Stop()
            Goto, Full
        }
    TotalTime += (A_TickCount - JoinStartTime)
    JoinStartTime := A_TickCount
    ImageSearch, , , 0, 0, 1920, 1080, *5 PATH\TO\\JOINBANNER.png
    If ErrorLevel = 0
        {
        JoinMsg := 1
        If TimeMsg = 1
            Sleep, 2000

        If detect = 0
            Sendraw, =
            detect := 1

        Sleep, 1000
        Send, {Enter}
        Sleep, 200
        Send, Player detected, Welcome Guardian.
        Sleep, 200
        Send, {Enter}
        Sleep, 200
        MouseMove, 1227, 528, 5
        Sleep, 200
        Send, {LButton}
        Sleep, 200
        Send, {LButton}
        Sleep, 3000
        If detect = 1
            Sendraw, =
            detect := 0
        JoinMsg := 0
        }
    Sleep, 1000
    TotalTime += (A_TickCount - JoinStartTime)

    If TotalTime >= 175000
        {
        counter.Stop()
        Full := 0
        Goto, Closing
        }
}

CloseMsg() {
    SendRaw, -
    Sleep, 100
    run, f18.ahk, PATH\TO\keys
    Sleep, 200
}

Closing:
    Sleep, 200
    SendRaw, -
    Sleep, 200
    Send, {Enter}
    Send, Closing session...
    Send, {Enter}
    Sleep, 500
    Send, {F1}
    Sleep, 1000
    MouseMove, 1716, 48, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 1000
    MouseMove, 297, 779, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 1000
    MouseMove, 1777, 251, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 250
    If Full = 0
        CloseMsg()
    Sleep, 250
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {Esc}
    Sleep, 1000
    Send, {Enter}
    Sleep, 100
    Send, Session Closed.
    Sleep, 100
    Send, {Enter}
    Sleep, 2000
    goto, Joining

Full:
    counter.Stop()
    Full := 1
    CloseMsg()
    Sleep, 200
    Send, {Enter}
    Sleep, 100
    Send, Lobby is now full.
    Sleep, 100
    Send, {Enter}
    Goto, Closing

Joining:
    Send, M
    Sleep, 500
    MouseMove, 1227, 528, 5
    Sleep, 500
    Loop, 4 {
        ImageSearch, , , 1392, 148, 1873, 251, *10 PATH\TO\EMPTY.png
        If ErrorLevel = 0 
            {
            Send {Enter}
            Sleep, 100
            Send, No players detected, Restarting Destiny 2...
            Sleep, 100
            Send {Enter}
            Sleep, 200
            Goto, Empty
            }
        Sleep, 200
    }

Retry:
    Send, {Enter}
    SendRaw, Traveling to Golg Maze now!
    Sleep, 200
    Send, {Enter}
    MouseMove, 1628, 898, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 8000
    Loop, 20 {
        ImageSearch, , , 0, 0, 1920, 1080, *20 PATH\TO\BANNERORBIT.png
        If ErrorLevel = 0
            Goto, GolgRetry

        Sleep, 200
    }
    Send, {Enter}
    Sleep, 100
    Send, Please pull out your ghost and leave the fireteam after loading into Golg Maze.
    Sleep, 100
    Send, {Enter}
    Loop, 35 {
        ImageSearch, , , 0, 0, 1920, 1080, *20 PATH\TO\BANNERORBIT.png
        If ErrorLevel = 0
            Goto, GolgRetry

        Sleep, 200
    }
    Send, {Enter}
    Sleep, 100
    SendRaw, Check out the live status and discord bot at bepbot.nl
    Sleep, 100
    Send, {Enter}
    Loop, 30 {
        ImageSearch, , , 0, 0, 1920, 1080, *20 PATH\TO\BANNERORBIT.png
        If ErrorLevel = 0
            Goto, GolgRetry

        Sleep, 200
    }
    Send, {Enter}
    Sleep, 100
    SendRaw, Please consider donating, it helps me keep this bot online 24/7!
    Sleep, 100
    Send, {Enter}
    Sleep, 200
    Send, {Enter}
    Sleep, 100
    SendRaw, bepbot.nl/donate
    Sleep, 100
    Send, {Enter}
    Sleep, 400
    MouseMove, 960, 900, 5
    loop, 30 {
        PixelSearch, , , 268, 936, 268, 936, 0xB7551F, 10, RGB
        If ErrorLevel = 0
            Goto, End

        ImageSearch, , , 0, 0, 1920, 1080, *20 PATH\TO\BANNERORBIT.png
        If ErrorLevel = 0
            Goto, GolgRetry

        ImageSearch, , , 0, 0, 1920, 1080, *5 PATH\TO\MAP.png
        If ErrorLevel = 0
            Goto, Relaunch
        
        MouseMove, 960, 900, 5
        Sleep, 2000
        Send, {LButton}
        }
    Goto, GolgRetry

End:
    Sleep, 200
    Send, {Enter}
    Sleep, 200
    Send, Bot will leave in 10 seconds.
    Sleep, 200
    Send, {Enter}
    Sleep, 10000
    Send, {Enter}
    Sleep, 200
    Send, Bot is leaving now.
    Sleep, 200
    Send, {Enter}
    Sleep, 500
    Send, {Esc}
    Sleep, 500
    MouseMove, 703, 592,5
    Sleep, 500
    Send, {LButton}
    Sleep, 1500
    Send, {Return}

SelectScan:
    loop, 100 {
        ImageSearch, , , 0, 0, 1920, 1080, PATH\TO\BANNER.png
        If ErrorLevel = 0
            Goto, Selecting

        Sleep, 500
    }
    Goto, Crash

Selecting:
    Sleep, 2000
    MouseMove, 1350, 455, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    run, AFKBot2.ahk
    ExitApp

GolgRetry:
    sleep, 2000
    MouseMove, 960, 900, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 200
    Send, {LButton}
    Sleep, 500
    Send, {Tab}
    Sleep, 2000
    MouseMove, 960, 540, 5
    Sleep, 500
    Loop, 6 {
        ImageSearch, , , 0, 0, 1920, 1080, *5 PATH\TO\MAP.png
        If ErrorLevel = 0
            Goto, Relaunch

        Sleep, 500
    }
    Send, {Enter}
    Sleep, 500
    Send, {Tab}
    Sleep, 2000
    MouseMove, 960, 540, 5
    Sleep, 500
    Loop, 6 {
        ImageSearch, , , 0, 0, 1920, 1080, *5 PATH\TO\MAP.png
        If ErrorLevel = 0
            Goto, Relaunch

        Sleep, 500
    }
    Goto, Crash

Relaunch:
    SLeep, 100
    Send, {Enter}
    Sleep, 100
    Send, Error has been detected, retrying...
    Sleep, 100
    Send, {Enter}
    Sleep, 500
    MouseMove, 1193, 158, 5
    Sleep, 500
    Send {LButton}
    Sleep, 500
    Send {LButton}
    Sleep, 1000
    MouseMove, 1227, 528, 5
    Sleep, 500
    Send {LButton}
    Sleep, 500
    Send {LButton}
    Sleep, 1000
    MouseMove, 1628, 900, 5
    Sleep, 500
    Send {LButton}
    Sleep, 500
    Send {LButton}
    Sleep, 1000
    Goto, Retry

Crash:
    Sleep, 200
    SendRaw, -
    Sleep, 100
    Send, {Enter}
    Sleep, 200
    Send, Bot seems to have crashed, Please try again in the next Lobby.
    Sleep, 200
    Send, {Enter}
    Sleep, 500
    Send, {Enter}
    Sleep, 500
    Send, {Enter}
    Sleep, 200
    Send, Bot seems to have crashed, Please try again in the next Lobby.
    Sleep, 200
    Send, {Enter}
    Sleep, 200
    run, f19.ahk, C:\Users\Bep\Desktop\Bot\keys
    Sleep, 200
    Sleep, 2000

Empty:
    Sleep, 200
    SendRaw, -
    Sleep, 1000
    Send !{f4}
    Sleep, 4000
    Run, destinyshutdown.bat, C:\Users\Bep\Desktop\Bot
    CoordMode, Mouse, Screen
    MouseMove, 113, 444, 5
    sleep, 200
    Send, {LButton}
    Sleep, 300
    Send, {LButton}
    loop, 80 {
        ImageSearch, , , 0, 0, 1920, 1080, *40 PATH\TO\INTRO.png
        If ErrorLevel = 0
        {
            Send, {Enter}
            MouseMove, 930, 920, 5
            Send, {LButton}
            Sleep, 500
            Send, {LButton}
            Sleep, 1000
            Send, {LButton}
            Goto, SelectScan
        }
        Sleep, 1000
    }
    Sleep, 500
    MouseMove, 989, 1060, 5
    Sleep, 500
    Send, {LButton}
    Sleep, 500
    Send, {LButton}
    Sleep, 2000
    Send, {LButton}
    Goto, SelectScan

8::pause, toggle
