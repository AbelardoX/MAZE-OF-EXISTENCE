# REGRA DE ARQUITETURA E COMPORTAMENTO: GAMEMAKER STUDIO 2+ E AIDER

Você está atuando como assistente de programação para o projeto "Maze of Existence" em GameMaker Language (GML). Para garantir a integridade do projeto e a qualidade do código, você DEVE obedecer rigorosamente às regras abaixo.

## 1. REGRA DE OURO: CRIAÇÃO DE ARQUIVOS (Segurança)
Para evitar a corrupção do arquivo de projeto (`.yyp`) e conflitos de metadados (`.yy`), você NÃO deve tentar criar arquivos novos via terminal ou comandos do sistema operacional.

**Fluxo de Trabalho Obrigatório para Novos Arquivos:**
1. Quando eu solicitar um novo Script ou Objeto, você deve me responder: *"Por favor, crie o arquivo [NOME] na IDE do GameMaker, adicione um comentário inicial e me avise."*
2. Somente após minha confirmação, você deve usar sua ferramenta de edição para injetar o código no arquivo.
3. Se o arquivo estiver vazio, adicione um comentário `// Iniciado` na primeira linha antes de aplicar qualquer código.

## 2. GERENCIAMENTO E INTEGRAÇÃO (Manual de Manutenção)
Sempre que editar o `.yyp` ou um `.yy`, siga este padrão estrito:
1. **Estrutura:** Mantenha a sintaxe JSON do `.yyp` perfeita (cuidado com vírgulas extras no final de listas).
2. **Isolamento:** Mantenha a lógica separada em arquivos modulares (ex: Scripts separados para cada Skill, Input, etc).
3. **Registro:** Ao criar recursos (como um novo Script de Skill), adicione-o ao arquivo `MAZE OF EXISTENCE.yyp` seguindo o padrão atual do projeto:
   `{"id":{"name":"NOME_DO_RECURSO","path":"diretorio/NOME_DO_RECURSO.yy",},},`

## 3. QUALIDADE E PADRONIZAÇÃO DE CÓDIGO
1. **Data-Driven Design:** Sempre que possível, utilize estruturas de dados (Structs/Arrays) para gerenciar sistemas (como o Skill System). Adicionar novas mecânicas deve exigir apenas a inserção de novos dados em um script de banco de dados (`scr_skill_database.gml`), nunca a criação de novos ifs/elses manuais.
2. **Modularização:** Separe a lógica de desenho (Draw Event) da lógica de estado (Step/Create Event).
3. **Comportamento YOLO:** Quando eu utilizar o comando `Ctrl+Y` (YOLO), você deve ser direto, aplicar as correções e rodar testes de sanity check se possível.
4. **Isolamento de Seções:** Nunca vincule tamanhos ou posições de seções diferentes da UI (Superior, Central, Inferior). Cada contêiner de UI deve ter seu posicionamento individualizado.

## 4. COMUNICAÇÃO
1. Seja técnico, direto e focado em arquitetura de software.
2. Ao final de cada implementação, forneça um breve resumo arquitetural do que foi alterado e como os novos arquivos se conectam ao restante da base.