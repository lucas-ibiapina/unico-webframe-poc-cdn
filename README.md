# Check Onboarding Go Template

Este repositório tem o propósito de servir como template para projetos desenvolvidos em Golang pela squad de Onboarding do unico | check. Consta aqui também a documentação da estrutura de código acordada pela squad, que embora esteja sujeita a constante evolução, deverá ser seguida para os projetos desenvolvidos em Go.

## Como Usar Este Template:

Para usar este template, siga as instruções contidas [neste link](https://docs.github.com/pt/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template).

## Estrutura de Diretórios

A estrutura acordada pela squad para os projetos em Golang do unico | check onboarding se baseia livremente nos princípios descritos pela [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) e em um [conjunto de padrões frequentemente adotados pela comunidade de Golang](https://github.com/golang-standards/project-layout). O objetivo é que com a adoção destes padrões tenhamos um código com baixo acoplamento às especificidades da infraestrutura que o suporta, além de nos mantermos aderentes a padrões amplamente reconhecidos pela comunidade.

Abaixo estão descritos os diretórios e seus respectivos propósitos:

### `/api`

Arquivos de documentação de APIs, como Postman, Swagger, etc.

### `/build`

Arquivos relacionados ao processo de build e/ou integração contínua.

### `/cmd`

Aqui entra o arquivo `main.go` que serve como ponto de entrada para a execução do projeto. 

O código contido neste diretório deve ser breve, tendo como responsabilidade somente inicializar a aplicação importando o código dos diretórios `/internal` e/ou `/pkg`.

### `/config`

Arquivos de configuração do projeto, sejam eles templates ou configurações default.

### `/deployment`

Arquivos de template e/ou configuração para sistemas de deploy e orquestração como kubernetes, docker-compose, terraform, etc.

### `/internal`

Código "privado" do projeto, sendo portanto inacessível caso ele venha a ser acessado como uma dependência de outro projeto.

Aqui, portanto, estará contida a maior parte do código do projeto, que deverá seguir uma estrutura como esta:

```
/shared
/{contexto de domínio}
    /domain
        /entity
    /app
        /usecase
    /infra
        /repository
        /gateway
        /entrypoint
            /queue
            /rest

```
- `/shared`: Pacotes compartilhados entre diferentes contextos de domínio ou usados para a inicialização da aplicação.

- `/{contexto de domínio}/`: Código referente a um contexto específico do domínio.

- `/{contexto de domínio}/domain`: Código que diz respeito exclusivamente ao domínio, ou seja, as regras de negócio do domínio desacopladas de sua infraestrutura subjacente.

- `/{contexto de domínio}/domain/entity`: Entidades de domínio que representam um conjunto de dados e operações do negócio.

- `/{contexto de domínio}/usecase`: Casos de uso de domínio que implementam uma regra de negócio/caso de uso específico.

- `/{contexto de domínio}/infra`: Código específico que traz as implementações que são necessárias para o correto funcionamento dos serviços e entidades de domínio.

- `/{contexto de domínio}/infra/repository`: Repositórios que contém as implementações específicas que satisfazem as interfaces requisitadas pelos serviços de domínio, conectando-se a bancos de dados específicos, por exemplo.

- `/{contexto de domínio}/infra/entrypoint`: Código de comunicação externa da aplicação, como a camada de roteamento de requests http de uma API, por exemplo.

- `/{contexto de domínio}/infra/gateway`: Código para acesso a dependencias externas.

Nessa estrutura, torna-se aparente a preocupação de isolar as regras de negócio da infraestrutura da aplicação. O objetivo deste isolamento é possibilitar eventuais trocas de provedores de determinadas partes da infraestrutura, mantendo o restante do código da aplicação o mais intacto possível. Também buscamos, com isso, obter maior testabilidade e padronização de nossas aplicações.

### `/pkg`

Código "público" do projeto, sendo portanto acessível caso ele venha a ser acessado como uma dependência de outro projeto.

- `/pkg/dto`: ["Data Transfer Objects"](https://en.wikipedia.org/wiki/Data_transfer_object) da aplicação, objetos que carregam apenas dados moldados conforme as necessidades de uma determinada entrada ou saída da aplicação.

### `/script`

Scripts em geral usados em operações necessárias para a aplicação mas que não se encaixam em outros diretórios do projeto.

### `/test`

Arquivos relacionados a construção e execução de testes de integração e/ou end to end.

