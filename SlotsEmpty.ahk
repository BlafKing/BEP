Sleep, 1000
Msg0:
    Msg0 := 0
    Loop, {
        If Msg0 = 0
            {
            Sleep, 200
            run, f13.ahk, C:\Users\Bep\Desktop\Bot\keys
            Sleep, 500
            Msg0 := 1
        }
        ImageSearch, , , 1392, 148, 1873, 251, *30 C:\Users\Bep\Desktop\Bot\Images\1.png
        If ErrorLevel = 1
            Sleep, 3000
            ImageSearch, , , 1392, 148, 1873, 251, *30 C:\Users\Bep\Desktop\Bot\Images\1.png
            If ErrorLevel = 1
                Goto, Msg1
        Sleep, 1000
    }

Msg1:
    Msg1 := 0
    Loop, {
        If Msg1 = 0
            {
            Sleep, 200
            run, f14.ahk, C:\Users\Bep\Desktop\Bot\keys
            Sleep, 500
            Msg1 := 1
        }

        ImageSearch, , , 1392, 148, 1873, 251, *40 C:\Users\Bep\Desktop\Bot\Images\1.png
        If ErrorLevel = 0
            Sleep, 3000
            ImageSearch, , , 1392, 148, 1873, 251, *40 C:\Users\Bep\Desktop\Bot\Images\1.png
            If Errorlevel = 0
            Goto, Msg0

        ImageSearch, , , 1392, 254, 1873, 357, *30 C:\Users\Bep\Desktop\Bot\Images\2.png
        If ErrorLevel = 1
            Sleep, 3000
            ImageSearch, , , 1392, 254, 1873, 357, *30 C:\Users\Bep\Desktop\Bot\Images\2.png
            If ErrorLevel = 1
                Goto, Msg2
        Sleep, 1000
    }

Msg2:
    Msg2 := 0
    Loop, {
        If Msg2 = 0
            {
            Sleep, 200
            run, f15.ahk, C:\Users\Bep\Desktop\Bot\keys
            Sleep, 500
            Msg2 := 1
        }

        ImageSearch, , , 1392, 254, 1873, 357, *40 C:\Users\Bep\Desktop\Bot\Images\2.png
        If ErrorLevel = 0
            Sleep, 3000
            ImageSearch, , , 1392, 254, 1873, 357, *40 C:\Users\Bep\Desktop\Bot\Images\2.png
            If ErrorLevel = 0
                Goto, Msg1

        ImageSearch, , , 1392, 360, 1873, 463, *20 C:\Users\Bep\Desktop\Bot\Images\3.png
        If ErrorLevel = 1
            Sleep, 3000
            ImageSearch, , , 1392, 360, 1873, 463, *20 C:\Users\Bep\Desktop\Bot\Images\3.png
            If ErrorLevel = 1
                Goto, Msg3
        Sleep, 1000
    }

Msg3:
    Msg3 := 0
    Loop, {
        If Msg3 = 0
            {
            Sleep, 200
            run, f16.ahk, C:\Users\Bep\Desktop\Bot\keys
            Sleep, 500
            Msg3 := 1
            }

        ImageSearch, , , 1392, 360, 1873, 463, *40 C:\Users\Bep\Desktop\Bot\Images\3.png
        If ErrorLevel = 0
            Sleep, 3000
            ImageSearch, , , 1392, 360, 1873, 463, *40 C:\Users\Bep\Desktop\Bot\Images\3.png
            If ErrorLevel = 0
                Goto, Msg2

        ImageSearch, , , 1392, 466, 1873, 569, *30 C:\Users\Bep\Desktop\Bot\Images\4.png
        If ErrorLevel = 1
            Sleep, 3000
            ImageSearch, , , 1392, 466, 1873, 569, *30 C:\Users\Bep\Desktop\Bot\Images\4.png
            If ErrorLevel = 1
                Goto, Msg4
        Sleep, 1000
    }

Msg4:
    Msg4 := 0
    Loop, {
        If Msg4 = 0
            {
            Sleep, 200
            run, f17.ahk, C:\Users\Bep\Desktop\Bot\keys
            Sleep, 500
            Msg4 := 1
            }

        ImageSearch, , , 1392, 466, 1873, 569, *40 C:\Users\Bep\Desktop\Bot\Images\4.png
        If ErrorLevel = 0
            Sleep, 3000
            ImageSearch, , , 1392, 466, 1873, 569, *40 C:\Users\Bep\Desktop\Bot\Images\4.png
            If ErrorLevel = 0
                Goto, Msg3
        Sleep, 1000
    }

=::pause, toggle

-::
ExitApp
