@lab.Título

Faça login na sua VM com as seguintes credenciais...

> [!aviso] Todas as credenciais necessárias estão na aba **Recursos**

---

Saudações! Este workshop foi projetado para melhorar sua experiência de desenvolvimento por meio de:

- Utilizar um ambiente remoto personalizado para um início rápido de projeto
- Estabelecer ambientes de teste temporários para avaliar suas modificações de acordo com as diretrizes da sua empresa
- Empregar ferramentas que simplificam o processo de gerenciamento de ambientes Azure e implantação do seu software
- Aproveitar testes de carga para identificação precoce de possíveis problemas
- Solucionar problemas em uma configuração de carga distribuída

> [!aviso] Quando você iniciou este laboratório, alguns provisionamentos foram acionados em segundo plano para implantar recursos em uma assinatura dedicada (ou seja, DevCenter, etc). Não há necessidade de pressa, pois os recursos podem não estar totalmente implantados se você pular a introdução. Leva aproximadamente 5-7 minutos para implantar tudo.

Durante este workshop, você receberá instruções para concluir cada etapa. Recomenda-se que você procure as respostas nos recursos e links fornecidos antes de olhar as soluções colocadas sob o painel '*Alternar solução*'.

> [!nota] Você encontrará as instruções e configurações esperadas para cada etapa do laboratório nestas caixas de **Tarefa**.
> Entradas e parâmetros a serem selecionados serão definidos; todo o resto pode permanecer nas configurações padrão, pois não têm impacto no cenário.
> Use as credenciais fornecidas para fazer login na assinatura do Azure localmente usando o Azure CLI e no [Portal do Azure](https://portal.azure.com).
> Instruções e soluções serão fornecidas para *azd*, *Azure CLI* e o portal, mas você também pode optar por usar o Portal do Azure durante todo o workshop, se preferir.

## O que é Engenharia de Plataforma

Enquanto as pessoas dão diferentes definições para DevOps (um trabalho, automação de processos, organização corporativa, mistura de Dev e Ops, etc), a Engenharia de Plataforma é a prática de projetar e construir cadeias de ferramentas e fluxos de trabalho que permitem capacidades de autoatendimento para organizações de engenharia de software na era nativa da nuvem. Ela se concentra na criação de uma plataforma padronizada que os desenvolvedores podem usar para construir, implantar e gerenciar aplicativos de forma eficiente. O objetivo é reduzir a complexidade, melhorar a produtividade dos desenvolvedores e garantir consistência ao longo do ciclo de desenvolvimento.

#### Aspectos chave da engenharia de plataforma incluem:

- Automação: Automatizar tarefas repetitivas para reduzir a intervenção manual.
- Padronização: Criar ambientes e fluxos de trabalho padronizados para garantir consistência.
- Autoatendimento: Permitir que os desenvolvedores provisionem e gerenciem seus próprios ambientes e recursos.
- Escalabilidade: Projetar plataformas que possam escalar conforme as necessidades da organização.
- Segurança: Garantir que as melhores práticas de segurança estejam integradas na plataforma.

Embora tanto a engenharia de plataforma quanto o DevOps visem melhorar a eficiência e a eficácia do desenvolvimento e operações de software, eles se concentram em aspectos diferentes e têm funções distintas:

**Escopo**

- Engenharia de Plataforma: Foca na construção e manutenção da infraestrutura subjacente e ferramentas que os desenvolvedores usam para construir, implantar e gerenciar aplicativos. Cria uma plataforma padronizada que abstrai as complexidades da infraestrutura subjacente.
- DevOps: Foca na colaboração entre as equipes de desenvolvimento e operações para agilizar o processo de entrega de software. Enfatiza práticas como integração contínua, entrega contínua e infraestrutura como código.

**Responsabilidades**

- Engenheiros de Plataforma: Responsáveis por criar e manter a plataforma, garantindo que ela atenda às necessidades das equipes de desenvolvimento e fornecendo capacidades de autoatendimento.
- Engenheiros de DevOps: Responsáveis por implementar e gerenciar os pipelines de CI/CD, automatizar processos de implantação e garantir a confiabilidade e escalabilidade dos aplicativos em produção.

**Objetivos**

- Engenharia de Plataforma: Visa fornecer um ambiente de desenvolvimento contínuo e eficiente que reduz o atrito e aumenta a produtividade dos desenvolvedores.
- DevOps: Visa melhorar a colaboração entre desenvolvimento e operações, reduzir o tempo de lançamento no mercado e garantir a estabilidade e confiabilidade dos aplicativos.

Em resumo, a engenharia de plataforma se concentra na construção das ferramentas e infraestrutura que os desenvolvedores usam, enquanto o DevOps se concentra nos processos e práticas que permitem a entrega e operações eficientes de software. Ambos são essenciais para o desenvolvimento moderno de software, mas abordam desafios diferentes dentro da organização.

## Visão da Microsoft

!IMAGEM[plateng2.png](instructions281629/plateng2.png)

Ao embarcar em sua própria jornada de engenharia de plataforma com a Microsoft, você provavelmente encontrará três movimentos principais:

- "**Comece Certo**" foca em equipar seus desenvolvedores com ferramentas de autoatendimento, permitindo que eles iniciem seus projetos rapidamente enquanto aderem às melhores práticas da sua empresa definidas por meio de modelos e políticas.
- "**Mantenha Certo**" é tudo sobre manter a conformidade à medida que seus projetos crescem e garantir que os desenvolvedores continuem a seguir essas melhores práticas por meio de automação contínua e monitoramento.
- Finalmente, as campanhas "**Acerte**" ajudam os desenvolvedores a trazer sua infraestrutura DevOps existente, código e aplicativos para conformidade com os padrões em evolução da sua empresa.

Mas o melhor trabalho de conformidade parece "gratuito" para o desenvolvedor - é automatizado, invisível e tão integrado nas ferramentas e processos que grande parte dele está embutido.

Para responder a esses três movimentos, a empresa precisa configurar uma plataforma com uma caixa de ferramentas composta por vários produtos:

!IMAGEM[plateng1.png](instructions281629/plateng1.png)

Como Microsoft, oferecemos n produto para cada um desses componentes

!IMAGEM[plateng3.png](instructions281629/plateng3.png)

## Cenário

Não podemos cobrir todos esses produtos em um único laboratório, então vamos nos concentrar em alguns deles que têm grande tração com nossos clientes.

O objetivo do workshop é editar o código de uma API simples de *Gerenciamento de Pedidos*, implantá-la no Azure e detectar possíveis problemas usando testes de carga e monitoramento.

Usaremos os seguintes serviços:

- [Microsoft Dev Box][devbox]
- [Azure Deployment Environment][ade]
- [Azure Developer CLI][azd]
- [Azure Load Testing][loadtesting]
- [Application Insights][appinsights]

!IMAGEM[global-diagram.png](instructions281629/global-diagram.png)

[az-portal]: https://portal.azure.com
[devbox]: https://learn.microsoft.com/en-us/azure/dev-box/overview-what-is-microsoft-dev-box
[ade]: https://learn.microsoft.com/en-us/azure/deployment-environments/overview-what-is-azure-deployment-environments
[azd]: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview
[loadtesting]: https://learn.microsoft.com/en-us/azure/load-testing/overview-what-is-azure-load-testing
[appinsights]: https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview
[devportal]: https://devportal.microsoft.com/
[functionloadtesting]: https://learn.microsoft.com/en-us/azure/load-testing/how-to-create-load-test-function-app
[applicationmap]: https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-map

===

# Laboratório 1: Faça alterações no projeto

[devportal]: https://devportal.microsoft.com/
[vscode]: https://code.visualstudio.com/
[azure]: https://portal.azure.com/

## Configure seu ambiente de desenvolvimento

Azure DevBox é um ambiente de desenvolvimento fornecido pela Microsoft Azure. É essencialmente um ambiente de desenvolvimento pré-configurado baseado em nuvem que os desenvolvedores podem usar para escrever, executar e depurar seu código. Aqui estão algumas de suas vantagens:

- **Ambiente Pré-configurado**: O Azure DevBox vem com um ambiente de desenvolvimento pré-configurado, que inclui uma variedade de linguagens de programação populares, ferramentas de desenvolvimento e frameworks. Isso economiza tempo e esforço dos desenvolvedores na configuração de seu próprio ambiente.
- **Acesso de Qualquer Lugar**: Como o Azure DevBox é baseado em nuvem, os desenvolvedores podem acessar seu ambiente de desenvolvimento de qualquer lugar, em qualquer dispositivo. Isso o torna uma ótima ferramenta para equipes remotas e arranjos de trabalho flexíveis.
- **Escalabilidade**: O Azure DevBox pode escalar facilmente para cima ou para baixo com base nas necessidades do projeto. Isso significa que os desenvolvedores podem escolher a quantidade certa de recursos para seu projeto, sem se preocupar com super ou subprovisionamento.
- **Integração com Serviços Azure**: O Azure DevBox é totalmente integrado com outros serviços Azure, facilitando a construção, teste e implantação de aplicativos que usam esses serviços.
- **Segurança**: O Azure DevBox é hospedado no Azure, o que significa que se beneficia das medidas de segurança do Azure. Isso inclui recursos como Azure Security Center, Azure Active Directory e ofertas de conformidade.
- **Colaboração**: O Azure DevBox suporta colaboração em tempo real entre desenvolvedores. Isso facilita para as equipes trabalharem juntas no mesmo código, independentemente de sua localização física.

Usaremos uma Dev Box com uma imagem personalizada destinada ao desenvolvimento full stack. A Dev Box inclui [VS Code][vscode] com algumas extensões, como Node.js, git, Azure CLI e azd.

> [!nota] **Tarefa**
> 
> - Faça login no portal do Azure
> - Encontre o DevCenter e verifique o projeto e sua configuração

>[+] *Alternar Solução*
> 
> 1. Abra o [portal do Azure][azureportal]
> 1. Faça login usando as credenciais fornecidas (**veja a aba Recursos**)
> 1. Procure o grupo de recursos chamado **rg-plateng**
> 1. Abra o recurso DevCenter
> 1. Como você pode ver, um projeto foi criado, com pools e definições de devbox. Esse é o que você poderá usar
> !IMAGEM[devcenter-project.png](instructions281629/devcenter-project.png)
> 1. No nível do devcenter (não no projeto!), um catálogo foi criado. Clique nele, ele contém definições de ambiente (*Infra como Código*) que os usuários podem usar e implantar sob demanda
> !IMAGEM[devcenter-catalog.png](instructions281629/devcenter-catalog.png)

> [!nota] **Tarefa**
> 
> - Faça login no portal do desenvolvedor e conecte-se à sua Dev Box
> - Abra o VS Code

>[+] *Alternar Solução*
> 
> 1. Abra o [portal do desenvolvedor][devportal]
> 1. Faça login usando as credenciais fornecidas (**veja a aba Recursos**).
> 1. Solicite uma nova DevBox, você pode escolher entre 2 perfis de VMs (**WebDevPool** e **WebDevPoolPowerful**)
> !IMAGEM[devportal.png](instructions281629/devportal.png)
> !IMAGEM[devportal2.png](instructions281629/devportal2.png)
> 1. Se desejar, você pode usar personalizações. Isso significa carregar um arquivo YAML contendo as personalizações que você deseja aplicar à sua devbox na inicialização.
> 1. !IMAGEM[devportal3.png](instructions281629/devportal3.png)
> 1. Uma vez que a Dev Box é criada, clique no botão __Conectar__
> 1. Aguarde até que a Dev Box inicie
> 1. Abra o VS Code
> 1. Verifique as extensões instaladas, você deve conseguir ver as extensões do Azure e do GitHub (entre outras)

> [!aviso]
> Um provisionamento do Azure DevBox pode levar até **uma hora** devido à inscrição no Intune. O grupo de produtos está trabalhando para reduzir esse tempo nos próximos meses. Como seu tempo nesta sala de aula é limitado, use a VM do laboratório em vez disso, ela atuará como sua "DevBox", pois os requisitos também foram instalados nela (NodeJS, VSCode, AZD, etc.). A criação que você acabou de fazer foi para entender a experiência do usuário que os desenvolvedores teriam na vida real.

## Clone o projeto

> [!nota] **Tarefa**
> 
> No seu **desktop**, clone o projeto [https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs](https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs)
> Coloque sua linha de comando dentro desta nova pasta.

>[+] *Alternar Solução*
>
> Use o terminal integrado para executar os seguintes comandos:
> 
> ```sh
> git clone https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs.git
> ```

## Atualize o código

> [!nota] **Tarefa**
> 
> Atualize o endpoint *qna* em *servicess/api/src/api.js* prefixando o valor de retorno com um prefixo de sua escolha

>[+] *Alternar Solução*
>
> 1. Abra o arquivo **services/api/src/api.js**
> 1. Localize a linha **answer: '42'**,
> 1. Substitua **'42'** por **'PREFIX 42'** onde **PREFIX** são suas iniciais

===

# Laboratório 2: Implante seu código no Azure

[resourcemanager]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview
[ade]: https://learn.microsoft.com/en-us/azure/deployment-environments/overview-what-is-azure-deployment-environments
[azd]: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview

Neste segundo laboratório, focaremos em como implantar nossos serviços no Azure.

Para fazer isso, precisamos:

- Provisionar recursos no Azure, como os serviços de computação que hospedarão nosso código, o banco de dados e o serviço de monitoramento
- Empacotar nosso código e implantá-lo nos recursos provisionados

## Provisionar recursos no Azure

O provisionamento de recursos pode ser feito [de várias maneiras][resourcemanager]:

- (Recomendado) Usando *Infraestrutura como Código* (IaC) como Bicep ou Terraform
- Usando o Azure CLI
- Usando APIs e SDKs
- A partir do Portal do Azure

Trabalhar com IaC pode ser um desafio em alguns contextos, como definir quem pode fazer o quê:

- Quem escreverá o IaC e garantirá que ele esteja em conformidade com os padrões e melhores práticas da empresa?
- Quem criará recursos usando IaC e como? (ou seja, quem precisa de direitos suficientes no Azure para provisioná-los? Como ser ágil?)

[Azure Deployment Environments][ade] resolve esses problemas fornecendo uma estrutura para criação de "definições de ambiente", provisionamento delas, atribuição de recursos a projetos e gerenciamento de permissões.
Os ambientes podem ser criados diretamente a partir do [portal do desenvolvedor][devportal] ou usando uma ferramenta compatível como o Azure Developer CLI (`azd`).

> [!nota] **Tarefa**
> 
> Crie um novo ambiente usando a definição **Function**

>[+] *Alternar Solução*
>
> 1. Abra o [portal do desenvolvedor][devportal]
> 1. Faça login usando as credenciais fornecidas, se necessário
> 1. Clique no botão **Novo** no canto superior esquerdo e clique na opção **Novo ambiente**. Copie o nome escolhido.
> 1. Escolha um nome curto e selecione **Project-1**
> 1. Selecione o tipo de ambiente **Dev** e a definição **Function**
> !IMAGEM[devcenter-ade.png](instructions281629/devcenter-ade.png)
> 1. Clique em **Próximo**
> 1. Use o mesmo nome de ambiente da etapa anterior e deixe a localização como está.
> 1. Clique em **Criar** e aguarde a criação do ambiente (pode levar alguns minutos)
> !IMAGEM[devcenter-ade-creation.png](instructions281629/devcenter-ade-creation.png)

## Implantar serviços

[*azd*][azd] simplifica o processo de criação de recursos e implantação de código, fornecendo uma abstração simples sobre as várias integrações (por exemplo, com serviços de computação e gerenciamento).

> [!nota] **Tarefa**
> 
> - Usando [*azd*][azd], selecione o ambiente ADE que você criou anteriormente
> - Implante suas aplicações (serviços azd) no ambiente selecionado

> [!aviso] 
> Certifique-se de que a pasta atual da sua linha de comando seja a que você acabou de clonar. Você deve estar dentro da pasta clonada, não na pasta pai.

>[+] *Alternar Solução*
>
>1. Habilite a integração do Dev Center
>
>```sh
>azd config set platform.type devcenter
>```
>
>2. Faça login no Azure usando **azd**
>
>```sh
>azd auth login
>```
>
>3. Liste os ambientes disponíveis usando **env list**
>
>```sh
>azd env list
>```
>
>4. Selecione o ambiente remoto que foi criado via portal do desenvolvedor
>
>```sh
>azd env select <ade-environment-name>
>```
>
>5. Implante serviços no ambiente selecionado usando a configuração definida em **azure.yaml**
>
>```sh
>azd deploy
>```
> !IMAGEM[azd-deploy.png](instructions281629/azd-deploy.png)

Siga o assistente e aguarde até que a implantação termine.
Você deve ter acesso à URL do serviço implantado (por exemplo, Function App) e ao grupo de recursos que foi usado para a implantação.

## Testar serviços implantados

> [!nota] **Tarefa**
> 
> Teste a nova função implantada e certifique-se de que as alterações feitas na última etapa do Laboratório nº 1 estão sendo levadas em consideração na resposta da função.

> [!dica] **Dica**
> 
> Você pode usar o arquivo *test.http* fornecido para testar a nova função implantada

>[+] *Alternar Solução*
>
> 1. Abra o **test.http**
> 1. Atualize a variável **@host** para apontar para sua Function App
> 1. Use o botão **Enviar Solicitação** no topo da linha 3 para enviar uma solicitação. Ele vem da extensão **REST Client (by Huachao Mao)**, normalmente já instalada no seu VS Code
> !IMAGEM[request.png](instructions281629/request.png)
> 1. Certifique-se de ver a alteração que você fez no final do Laboratório 1 (por exemplo, adicionando um prefixo à resposta)

===

# Laboratório 3: Teste de carga

## Criar um teste de carga

Usar testes de carga pode ajudar a identificar possíveis problemas (por exemplo, erros e latência) muito cedo e reduzir o impacto desses problemas nos seus usuários.

Azure Load Testing é um serviço baseado em nuvem fornecido pela Microsoft Azure que permite aos desenvolvedores simular altos volumes de tráfego de usuários para seus aplicativos. Este serviço é projetado para identificar possíveis gargalos de desempenho e garantir que os aplicativos possam lidar com altas cargas, especialmente durante os horários de pico.

Benefícios do Azure Load Testing:

- **Escalabilidade**: O Azure Load Testing pode simular milhares a milhões de usuários virtuais, permitindo que você teste seu aplicativo em várias condições de carga.
- **Facilidade de Uso**: Com sua interface intuitiva e modelos de teste pré-configurados, o Azure Load Testing facilita a configuração e execução de testes de carga.
- **Relatórios Detalhados**: O Azure Load Testing fornece relatórios detalhados e análises em tempo real, ajudando você a identificar e resolver gargalos de desempenho.
- **Custo-Efetivo**: Com o Azure Load Testing, você paga apenas pelo que usa. Isso o torna uma solução de teste de carga econômica.

Integração com outros serviços:

O Azure Load Testing se integra perfeitamente com outros serviços Azure. Por exemplo, ele pode ser usado em conjunto com o Azure Monitor e o Application Insights para fornecer métricas de desempenho detalhadas e insights. Ele também se integra com o Azure DevOps, permitindo que você incorpore testes de carga em seu pipeline de CI/CD.

## Executar o teste

> [!nota] **Tarefa**
> 
> - Crie um teste de carga para o endpoint `Function`
> - Limite a duração do teste para **3 minutos**

> [!dica] **Dica**
> 
> Use a integração direta do [Azure Load Testing com Azure Functions][functionloadtesting]

>[+] *Alternar Solução*
>
> 1. Localize o Function App no Portal do Azure
> 1. Clique na lâmina **Load Testing (Preview)**
> 1. Clique no botão **Criar teste**
> 1. Selecione o recurso existente do Azure Load Testing e forneça um nome curto e uma descrição do teste
> 1. Clique em **Adicionar solicitação**
> 1. Certifique-se de que a solicitação pré-preenchida aponte para o endpoint da sua Function e use o método HTTP correto (**POST**)
> 1. Selecione a guia de corpo, defina o valor **Tipo de dados** como **Visualização JSON** e cole o corpo da solicitação usado no arquivo **test.http**
> 1. Valide a solicitação usando o botão **Adicionar**
> 1. Selecione a guia **Configuração de carga** e defina **Duração do teste (minutos)** para 3
> 1. Clique em **Revisar + criar** e depois em **Criar**
> 1. O teste levará alguns segundos para ser criado e então você deverá ver um pop-up informando que o teste foi iniciado

À medida que o teste começa, você verá um painel de **Resultados do teste de carga** com várias métricas, como o número total de solicitações, taxa de transferência e porcentagem de erros.

> [!nota] **Tarefa**
> 
> - Descubra o tempo médio de resposta?

>[+] *Alternar Solução*
>
> 1. Localize o filtro **Agregação** no painel **Métricas do lado do cliente**
> 1. Desmarque a seleção existente, selecione **Média** e clique em **Aplicar**
> 1. Localize a métrica abaixo do gráfico em **Tempo de resposta (respostas bem-sucedidas)**. Esse é o tempo médio de resposta.

## Verifique sua pilha usando o Mapa de Aplicativos

Application Insights é um recurso do Azure Monitor e é um serviço fornecido pela Microsoft Azure que ajuda os desenvolvedores a monitorar o desempenho e o uso de seus aplicativos web ao vivo. Ele coleta automaticamente dados de telemetria, fornece ferramentas analíticas e ajuda a diagnosticar problemas e entender o que os usuários realmente fazem com seu aplicativo.

Os principais recursos do Application Insights incluem:

- **Monitoramento de Desempenho**: Ele fornece insights em tempo real sobre o desempenho do seu aplicativo e identifica quaisquer gargalos.
- **Análise de Uso**: Ele rastreia como os usuários estão interagindo com seu aplicativo e identifica quaisquer tendências ou padrões.
- **Mapeamento de Dependência de Aplicativos**: Ele visualiza os componentes do seu aplicativo e suas interações, ajudando você a entender o impacto de quaisquer mudanças ou falhas.
- **Rastreamento de Exceções**: Ele captura e analisa exceções em seu aplicativo, ajudando você a diagnosticar e corrigir problemas mais rapidamente.

O Mapa de Aplicativos é um recurso dentro do Application Insights que fornece uma visão geral visual dos componentes do seu aplicativo e suas interações. Ele mostra o fluxo de solicitações entre esses componentes e ajuda a identificar quaisquer falhas ou gargalos de desempenho. Isso facilita a compreensão da arquitetura do seu aplicativo e o diagnóstico de quaisquer problemas.

!IMAGEM[application-map.png](instructions281629/application-map.png)

> [!nota] **Tarefa**
> 
> - Descubra quais componentes são usados dentro da sua pilha/carga de trabalho
> - Qual componente depende do outro?
> - Onde é gasto a maior parte do tempo ao fazer uma solicitação para sua função?

> [!dica] **Dica**
> 
> Verifique a [visão geral do Mapa de Aplicativos][applicationmap]

>[+] *Alternar Solução*
>
> 1. Abra o grupo de recursos no portal do Azure
> 1. Localize o recurso Application Insights
> 1. Clique na lâmina **Mapa de Aplicativos**
> 1. Você deve ver os vários componentes da pilha e suas dependências
> 1. Verifique a duração média gasta em cada componente e localize aquele onde a maior parte do tempo é gasto

===

# Laboratório 4: Investigar erros

À medida que você adiciona novos recursos ao seu aplicativo, algumas regressões podem aparecer, daí a necessidade de testar e monitorar para detectar e corrigir essas regressões.

Para simular a realização de alterações e implantação de novas versões, o Function App fornecido depende da variável de ambiente **RELEASE** para controlar seu comportamento e introduzir regressões, como lançar erros e injetar latência.

## Simular uma nova versão

> [!nota] **Tarefa**
> 
> - Atualize a configuração do Function Apps definindo a variável de ambiente **RELEASE** para **2**. A função deve começar a lançar erros para 10% das solicitações.

>[+] *Alternar Solução*
>
> 1. Abra o grupo de recursos no portal do Azure
> 1. Localize o Function App
> 1. Clique na lâmina **Variáveis de ambiente**
> 1. Clique na variável de ambiente **RELEASE** para editá-la
> 1. Defina o valor para **2** e clique em **Aplicar**
> 1. Clique em **Aplicar** para validar todas as alterações nas variáveis de ambiente
> 1. Selecione **Confirmar**

O Function App será recarregado e então adaptará seu comportamento para lançar erros a uma taxa de 10%

## Reexecutar o teste de carga

> [!nota] **Tarefa**
> 
> - Reexecute o teste de carga que você criou no laboratório anterior e observe se há alguma alteração em comparação com antes

>[+] *Alternar Solução*
>
> Você pode optar por criar um novo teste como fez no Laboratório 3 ou reexecutar um teste existente.
> Aqui está como você deve proceder se optar por reexecutar um teste:
> 1. Localize o Function App no Portal do Azure
> 1. Clique na lâmina **Load Testing (Preview)**
> 1. Selecione qualquer teste na seção **Execuções de teste**
> 1. Clique no botão **Reexecutar** no topo
> 1. Opcionalmente, forneça uma breve descrição (por exemplo, **Verificando erros**)
> 1. Clique no botão **Reexecutar**
> 1. O teste levará alguns segundos para ser criado e então você deverá ver um pop-up informando que o teste foi iniciado
> 1. Clique na nova execução de teste para acessar os resultados do teste

## Inspecionar erros

> [!nota] **Tarefa**
> 
> - Use o Application Insights para encontrar mais detalhes sobre o erro que você começou a observar.
> - Qual serviço e qual linha de código está lançando esse erro?

>[+] *Alternar Solução*
>
> 1. Abra o grupo de recursos no portal do Azure
> 1. Localize o recurso Application Insights
> 1. Você deve ver um pico de erros no painel **Solicitações falhadas**
> 1. Use a lâmina **Falhas** ou clique no gráfico de erros
> 1. Clique no código de resposta superior (**500**) no painel direito
> 1. Selecione a operação de amostra sugerida no painel direito
> 1. Você deve ver os detalhes dos erros, incluindo qualquer outro serviço que esteve envolvido na operação
> 1. Clique em **Rastreamentos e Eventos**
> 1. Selecione a exceção para acessar sua pilha de chamadas
> 1. Verifique a **mensagem** no painel direito e clique em **[mostrar mais]** para obter mais detalhes
> 1. Você deve ver uma referência a **Erro aleatório**, o arquivo **api.js** onde o erro foi acionado e o rastreamento de chamadas, incluindo números de linha

===

# Laboratório 5: Investigar problemas de latência

O objetivo deste laboratório é investigar possíveis problemas de latência.
A versão **3** introduz uma latência de 2 segundos na função, então você começará simulando a implantação dessa versão.

> [!nota] **Tarefa**
> 
> - Atualize a configuração do Function Apps definindo a variável de ambiente **RELEASE** para *3*. As solicitações agora devem ser 2 segundos mais lentas em comparação com antes.

>[+] *Alternar Solução*
>
> 1. Abra o grupo de recursos no portal do Azure
> 1. Localize o Function App
> 1. Clique na lâmina **Variáveis de ambiente**
> 1. Clique na variável de ambiente **RELEASE** para editá-la
> 1. Defina o valor para **3** e clique em **Aplicar**
> 1. Clique em **Aplicar** para validar todas as alterações nas variáveis de ambiente
> 1. Selecione **Confirmar**
> 
> O Function App será recarregado e então adaptará seu comportamento para injetar uma latência de 2 segundos

## Executar o teste de carga novamente

> [!nota] **Tarefa**
> 
> - Reexecute o mesmo teste de carga que você usou no laboratório anterior e observe se há alguma alteração em comparação com antes

>[+] *Alternar Solução*
>
> Você pode optar por criar um novo teste como fez no Laboratório 3 ou reexecutar um teste existente.
> 
> Aqui está como você deve proceder se optar por reexecutar um teste:
> 
> 1. Localize o Function App no Portal do Azure
> 1. Clique na lâmina **Load Testing (Preview)**
> 1. Selecione qualquer teste na seção **Execuções de teste**
> 1. Clique no botão **Reexecutar** no topo
> 1. Opcionalmente, forneça uma breve descrição (por exemplo, **Verificando problemas de latência**)
> 1. Clique no botão **Reexecutar**
> 1. O teste levará alguns segundos para ser criado e então você deverá ver um pop-up informando que o teste foi iniciado
> 1. Clique na nova execução de teste para acessar os resultados do teste

## Inspecionar problemas de desempenho

> [!nota] **Tarefa**
> 
> - Use o Application Insights para encontrar mais detalhes sobre o problema de latência que você começou a observar.

>[+] *Alternar Solução*
>
> 1. Abra o grupo de recursos no portal do Azure
> 1. Localize o recurso Application Insights
> 1. Você deve ver um aumento no tempo de resposta no painel **Tempo de resposta do servidor**
> 1. Use a lâmina **Desempenho** ou clique no gráfico de tempo de resposta
> 1. Você deve ver a duração de cada operação
> 1. A operação **qna** deve estar anormalmente lenta (+2 segundos) e você deve ver uma seta vermelha à direita da operação junto com a porcentagem de aumento na latência. Esse é o endpoint a ser investigado.
> 1. Você pode usar o **Profiler** para obter mais detalhes sobre a origem do problema

O Profiler no Application Insights é um recurso poderoso que permite aos desenvolvedores coletar dados detalhados de desempenho de um aplicativo web ao vivo. É essencialmente uma ferramenta de diagnóstico que ajuda você a entender as características de desempenho do seu aplicativo e encontrar a causa raiz de quaisquer problemas de desempenho.

Aqui estão alguns detalhes chave sobre o Profiler:

- **Rastreamento de Desempenho**: O Profiler pode coletar rastreamentos detalhados do desempenho do seu aplicativo, incluindo o tempo gasto em cada operação. Isso pode ajudar você a identificar quaisquer gargalos ou operações lentas no seu aplicativo.
- **Insights no Nível do Código**: O Profiler pode fornecer insights no nível de linhas individuais de código. Isso significa que você pode ver exatamente quais partes do seu código estão causando problemas de desempenho.
- **Baixo Overhead**: O Profiler é projetado para ter um baixo overhead, então ele não impactará significativamente o desempenho do seu aplicativo. Isso significa que você pode usá-lo em um ambiente ao vivo sem se preocupar em afetar seus usuários.
- **Integração com o Application Insights**: O Profiler é totalmente integrado com o Application Insights, então você pode correlacionar dados de desempenho com outros dados de telemetria coletados pelo Application Insights. Isso pode dar a você uma visão mais completa do desempenho do seu aplicativo.
- **Perfilamento Disparado**: Você pode configurar o Profiler para começar a coletar dados automaticamente quando certas condições forem atendidas, como um limite de desempenho específico sendo excedido. Isso pode ajudar você a capturar problemas de desempenho intermitentes que podem ser difíceis de reproduzir.

Se você quiser mais informações sobre o profiler, siga este [guia](https://learn.microsoft.com/en-us/azure/azure-monitor/profiler/profiler-overview)
