# 🍔 Tech Challenge - Fase 3 | Pós-graduação em Arquitetura de Software

Este repositório faz parte do projeto do **Tech Challenge da Fase 3** da pós-graduação em Arquitetura de Software da FIAP. O objetivo é provisionar a infraestrutura necessária para um sistema de autoatendimento de fast food, utilizando **Terraform** e os principais serviços de nuvem.

---

## 📦 Módulos Terraform

Este repositório contém módulos separados e reutilizáveis, cada um responsável por um componente específico da infraestrutura:

### 🔐 `cognito`
> Cria um User Pool e um User Pool Client no AWS Cognito para permitir autenticação dos clientes por CPF.

### 🖥️ `compute`
> Provisão de um cluster Kubernetes (Amazon EKS), incluindo configurações de IAM, security groups, e subnets.

### 🗃️ `database`
> Cria uma instância de banco de dados gerenciado (Amazon RDS) com engine PostgreSQL, pronta para ser consumida pelo sistema.

### 🌐 `gateway`
> Cria um API Gateway REST, define endpoints e integrações com funções Lambda para expor os serviços da aplicação.

### ⚙️ `lambda`
> Cria e configura funções Lambda para lógica de autenticação e integração com outros serviços como o Cognito e API Gateway.

---

## 🎯 Objetivo

Provisionar a infraestrutura em nuvem para o sistema de pedidos da lanchonete, atendendo aos seguintes requisitos:

- Autenticação de clientes com CPF via function serverless
- Integração com Cognito
- Deploy automatizado via GitHub Actions
- Separação da infraestrutura por repositórios
- Uso de banco de dados gerenciado
- Arquitetura serverless e escalável

---

## 🚀 Como usar os módulos

Você pode importar qualquer módulo no seu projeto principal Terraform:

```hcl
module "example" {
  source = "./modules/<nome-do-módulo>"
  # parâmetros específicos do módulo
}
```

---

## 📚 Requisitos

- Terraform 1.x
- AWS CLI configurado
- Conta na AWS com permissões adequadas