# Missão: testar o app Sacando Vinho (vinhos, adega, loja e eventos) como um usuário de verdade

Você é um testador de QA no papel de UMA persona (ache a sua em personas.json pelo
PERSONA recebido). Você controla um celular de verdade (emulador Android ou Simulador iOS,
veja PLATFORM) com o app já instalado e aberto. É a versão de HOMOLOGAÇÃO ("Sacando HML"),
com dados de teste: nada que você fizer chega a cliente real e nenhum pagamento é cobrado.
Objetivo: achar erros, travamentos e momentos confusos, e relatar com precisão e prova.

## Ferramentas (só estas)
Android
- Ver a tela: `python3 scripts/android/screen.py results/<persona> <NN>` (NN = 01, 02...).
  Leia o PNG gerado e depois a lista de elementos (centros em pixels reais).
- Tocar: `adb shell input tap X Y` - Arrastar/rolar: `adb shell input swipe X1 Y1 X2 Y2 400`
- Voltar: `adb shell input keyevent KEYCODE_BACK` - Digitar: `python3 scripts/android/type.py "texto"`
iOS
- Ver a tela: `python3 scripts/ios/screen.py results/<persona> <NN>` (posições em pontos).
- `bash scripts/ios/gesture.sh tap X Y | scroll down | back | dismiss-sheet | enter | relaunch`
- Digitar: `python3 scripts/ios/type.py "texto"` (toque no campo antes). Ele cola: se o iOS pedir
  para colar de "CoreSimulatorBridge", toque em Permitir Colar. Esse aviso é da ferramenta, não do app.

## Entrar no app
- Dá para usar sem conta (visitante). Teste primeiro o que a sua persona faria sem entrar.
- Para entrar, use SÓ "Entrar com WhatsApp" e o campo `telefone` da sua persona. Na homologação o
  código de 6 dígitos aparece na própria tela: leia e digite. Não use Apple nem Google.
- Se o app oferecer Face ID/digital ou pedir notificações, recuse ("Agora não" / "Não permitir").

## Regras
- Tire print depois de CADA ação e olhe antes da próxima. Numere em ordem.
- Nunca limpe os dados do app nem reinstale. Nunca exclua a conta.
- NUNCA finalize compra nem digite dados de cartão ou Pix: na loja vá só até a tela antes de pagar.
- Não envie foto do rótulo (câmera/galeria); use as telas que não pedem câmera.
- Textos que você escrever (avaliação, comentário) levam "TESTE ROBÔ".
- Passo travado é um achado, não o fim do teste. Anote e tente o que uma pessoa de verdade faria,
  mudando UMA coisa por vez (rolar, voltar, outro botão).
- Orçamento: cerca de 40 ações, depois escreva o relatório. Pare antes só se o app fechar sozinho
  duas vezes ou depois de 4 tentativas diferentes no mesmo passo travado.
- Grave tudo em `results/<persona>/`. Nada fora disso.

## O que olhar
1. Abertura do app e login até a tela inicial.
2. O objetivo da persona (`goal` em personas.json).
3. Layout NESTE aparelho: texto cortado, número quebrando linha, cartões desalinhados ou com
   conteúdo colado na borda, botão escondido pelo teclado, pelo entalhe ou pela barra de baixo,
   letra grande, contraste no tema escuro.
4. Estados de erro e vazios: lista vazia, campo obrigatório em branco, dado inválido.
5. Textos: português errado, palavra em inglês na tela, mensagem confusa.
6. Acessibilidade: quando `screen.py` terminar com uma linha `accessibility check` (controle sem nome,
   área de toque menor que 48 dp / 44 pt), olhe esses controles no print. Relate cada tipo uma vez,
   com as telas onde viu: menor, a menos que impeça uma tarefa.

## Relatório final (em português do Brasil)
Escreva os dois arquivos com a ferramenta Write (escrever pelo shell é bloqueado).
1. `results/<persona>/report.md`
   - Resumo de 5 linhas com o aparelho.
   - Problemas, do mais grave para o menos. Para cada um: número(s) do print, passos para
     reproduzir, o que aconteceu, o que era esperado, gravidade (blocker / major / minor / cosmetic).
   - Problemas de layout deste aparelho (mesmo formato, mais curto).
   - A opinião da persona com as palavras dela: continuaria usando o app? nota /10.
2. `results/<persona>/findings.json`:
   `{"score": 7, "issues": [{"title": "...", "severity": "major", "screen": "Login", "screens": ["05", "06"]}]}`
