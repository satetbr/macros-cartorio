# Macros para cartório

Coleção de 5 macros para o **Natus** (software de cartório de registro civil) que automatizam a averbação de certidões. Na rotina real, o tempo por registro caiu de ~15 para ~4 minutos, economizando cerca de 8 horas de trabalho por dia da equipe.

## Atalhos e funções

| Macro | Atalho | Descrição |
| --- | --- | --- |
| 1 | F9 | Gera o número do tombo da averbação. |
| 2 | F10 | Gera o recibo para praticar o ato da averbação. |
| 3 | F11 | Gera a averbação no registro. |
| 4 | F12 | Cria a averbação de CPF dos registros (extra). |
| 5 | ] | Gera o XML do registro para envio à Central de Registro Civil (extra). |

## Requisitos

- Windows
- Natus instalado e configurado
- Pulover's Macro Creator (para abrir o arquivo `.pmc`)

## Como usar

1. Abra o arquivo `2via.pmc` no Pulover's Macro Creator.
2. Deixe o Natus aberto no fluxo correto do atendimento.
3. Execute o atalho desejado (F9–F12 ou `]`).

## Arquivos relevantes

- `2via.pmc`: arquivo principal com as 5 macros.
- `GERADOR_XMLS.pmc`: macro de geração em lote de XMLs (rodou por 4 dias e gerou XMLs de todos os registros do sistema, mais de 1,5 milhão).
- `enviar_xml.ahk`: script auxiliar para o envio automático de XML (quando aplicável).
- `Screenshots\`: imagens usadas para reconhecimento de tela.

## Geração e envio em massa de XMLs

O `GERADOR_XMLS.pmc` foi utilizado para gerar, em lote, todos os XMLs do sistema (mais de 1,5 milhão de registros) ao longo de 4 dias. Em seguida, a macro **enviar_xml** realizou o envio desses XMLs para a **Central de Registro Civil (CRC)**.

## Observações importantes

- As macros dependem do layout de tela, do foco da janela e do tempo de resposta do sistema. Ajuste atrasos e posições se o ambiente mudar.
- O script `enviar_xml.ahk` usa caminhos absolutos para imagens e pasta de XML. Atualize `TargetFolder` e os caminhos de `ImageSearch` conforme o seu ambiente.

## Exemplo visual

![Pulover's Macro Creator](Screenshots/Screen_20260126093108.png)
