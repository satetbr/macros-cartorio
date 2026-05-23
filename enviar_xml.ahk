SetBatchLines, -1
CoordMode, Pixel, Window
CoordMode, Mouse, Window
SetTitleMatchMode, 2

TargetFolder := "\\VMDADOS\Setores\XMLS CRC" 

; LOOP PRINCIPAL
Loop
{
    ; --- 1. DETECÇÃO DE ARQUIVO (APENAS SE HOUVER MAIS DE UM) ---
    ArquivoParaProcessar := ""
    Loop
    {
        ContadorXML := 0
        ArquivoMaisAntigo := ""
        HoraMaisAntiga := 20990101000000
        
        Loop, Files, %TargetFolder%\*.xml
        {
            ContadorXML++
            
            If (A_LoopFileTimeModified < HoraMaisAntiga)
            {
                HoraMaisAntiga := A_LoopFileTimeModified
                ArquivoMaisAntigo := A_LoopFileName
            }
        }
        
        If (ContadorXML > 2)
        {
            ArquivoParaProcessar := ArquivoMaisAntigo
            Break
        }
        
        ; Se houver 0 ou 1 arquivo, ele fica esperando aqui
        Sleep, 2000 ; Espera 2 segundos antes de checar a pasta novamente
    }
    
    Clipboard := TargetFolder . "\" . ArquivoParaProcessar
    ClipWait, 1

    ; --- 2. PREPARAÇÃO DA JANELA ---
    IfWinNotExist, Carga de XML
    {
        MsgBox, 16, Erro, Janela "Carga de XML" não encontrada.
        Pause
    }
    WinActivate, Carga de XML
    WinWaitActive, Carga de XML, , 5
    WinMaximize, Carga de XML

    ; --- 3. CLICAR EM "ESCOLHER ARQUIVO" ---
    Loop
    {
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *75 \\VMDADOS\Setores\FUNCIONÁRIOS\Matheus\MACRO\Screenshots\Screen_20260126093108.png
        If (ErrorLevel = 0)
        {
            ClickX := FoundX + 20
            ClickY := FoundY + 10
            Click, %ClickX%, %ClickY%
            Break
        }
        Sleep, 50
    }

    ; --- 4. JANELA DE UPLOAD ---
    WinWaitActive, Abrir, , 10
    If !ErrorLevel
    {
        Send, ^v
        Sleep, 100
        Send, {Enter}
    }
    Else
    {
        Click
        Sleep, 1000
        IfWinActive, Abrir
        {
            Send, ^v
            Sleep, 100
            Send, {Enter}
        }
    }

    ; --- 5. CLICAR EM "ENVIAR" 
    WinWaitActive, Carga de XML, , 5
    Sleep, 200
    
    BotaoEnviarEncontrado := false
    
    Loop, 200 
    {
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *75 \\VMDADOS\Setores\FUNCIONÁRIOS\Matheus\MACRO\Screenshots\Screen_20260126092255.png
        If (ErrorLevel = 0)
        {
            ClickX := FoundX + 20
            ClickY := FoundY + 10
            Click, %ClickX%, %ClickY%
            BotaoEnviarEncontrado := true
            Break
        }
        Sleep, 50
    }
    
    If (BotaoEnviarEncontrado = false)
    {
        Send, {F5} 
        Sleep, 1000
        Loop
        {
            ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *75 \\VMDADOS\Setores\FUNCIONÁRIOS\Matheus\MACRO\Screenshots\Screen_20260126093108.png
            If (ErrorLevel = 0)
                Break
            Sleep, 100
        }
        Continue 
    }

    ; --- 6. AGUARDAR RESULTADO
    Loop
    {
        Clipboard := ""
        Send, ^a
        Sleep, 50
        Send, ^c
        ClipWait, 0.5
        
        If InStr(Clipboard, "Fim do Processamento") || InStr(Clipboard, "Erro de conexão") || InStr(Clipboard, "Erro de valida")
        {
            Click, 10, 200 
            Break 
        }
        
        Send, {WheelDown}
        Sleep, 400
        
        If (A_Index > 360)
        {
            MsgBox, O sistema travou ou a mensagem não apareceu.
            Pause
        }
    }

    ; --- 7. LIMPEZA E RETORNO ---
    FileDelete, %TargetFolder%\%ArquivoParaProcessar%
    
    Send, {Alt Down}{Left}{Alt Up}
    
    ; --- 8. TRAVA DE REINÍCIO ---
    Loop
    {
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *75 \\VMDADOS\Setores\FUNCIONÁRIOS\Matheus\MACRO\Screenshots\Screen_20260126093108.png
        If (ErrorLevel = 0)
            Break
        Sleep, 50
    }
    
    Sleep, 100
}

F12::ExitApp