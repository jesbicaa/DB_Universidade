DROP DATABASE portifolio;

create database portifolio;

use portifolio;

-- Tabela Cursos
CREATE TABLE Cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    duracao INT NOT NULL,  -- Duração do curso em anos
    requisitos VARCHAR(255) -- Requisitos para o curso
);

-- Tabela Alunos
CREATE TABLE Alunos (
    RA VARCHAR(20) PRIMARY KEY, -- RA no lugar de matrícula
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    celular VARCHAR(20) NOT NULL, -- whatsapp
    telefone VARCHAR(20), -- fixo
    email VARCHAR(255) NOT NULL
);

-- Tabela Alunos_Cursos (associa alunos a cursos)
CREATE TABLE Alunos_Cursos (
    fk_RA_aluno VARCHAR(20) NOT NULL,
    fk_id_curso INT NOT NULL,
    data_ingresso DATE,
    
    PRIMARY KEY (fk_RA_aluno, fk_id_curso),
    
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA),
    FOREIGN KEY (fk_id_curso) REFERENCES Cursos(id_curso)
);

-- Tabela Endereços
CREATE TABLE Enderecos (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20) NOT NULL, -- Numero do aluno (varchar porque existem casas com numeros, como exemplo: 101a, 101b)
    rua VARCHAR(255), -- Rua do aluno
    cidade VARCHAR(100), -- Cidade do aluno
    estado VARCHAR(2), -- Estado do aluno
    cep VARCHAR(10) NOT NULL, -- CEP
    tipo_endereco VARCHAR(20), -- Tipo de endereço (Residencial, Comercial, etc.)
    fk_RA_aluno VARCHAR(20) NOT NULL, -- RA do aluno
    
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA)
);

-- Tabela Professores
CREATE TABLE Professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL, -- cpf do professor
    email VARCHAR(255) NOT NULL,
    celular VARCHAR(20) NOT NULL, -- whatsapp
    telefone VARCHAR(20), -- fixo
    especializacao VARCHAR(255)
);

-- Tabela Matérias
CREATE TABLE Materias (
    codigo_materia VARCHAR(20) PRIMARY KEY, -- Código da matéria é a chave primária, pois o codigo é unico
    nome VARCHAR(255) NOT NULL,
    carga_horaria INT NOT NULL, -- Carga horária da matéria
    fk_id_professor INT NOT NULL, -- Professor responsável pela matéria
    
    FOREIGN KEY (fk_id_professor) REFERENCES Professores(id_professor)
);

-- Tabela Turmas
CREATE TABLE Turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    semestre VARCHAR(20) NOT NULL, -- Semestre (ex: 2025.1, 2025.2)
    quantidade_alunos INT NOT NULL, -- Quantidade de alunos por turma
    limite_alunos INT, -- Limite de alunos por turma
    fk_codigo_materia VARCHAR(20) NOT NULL, -- Código da matéria associada à turma
    
    FOREIGN KEY (fk_codigo_materia) REFERENCES Materias(codigo_materia)
);

-- Tabela Matrículas (associa alunos a turmas)
CREATE TABLE Matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    data_matricula DATE, -- Data da matrícula
    fk_RA_aluno VARCHAR(20) NOT NULL, -- RA do aluno
    fk_id_turma INT NOT NULL, -- Turma na qual o aluno está matriculado
   
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA),
    FOREIGN KEY (fk_id_turma) REFERENCES Turmas(id_turma)
);

-- Tabela Notas (armazena as notas dos alunos por matéria)
CREATE TABLE Notas (
    id_nota INT AUTO_INCREMENT PRIMARY KEY, 
    nota DECIMAL(5,2) NOT NULL, -- Nota do aluno (pode ser de 0 a 10)
    fk_RA_aluno VARCHAR(20) NOT NULL, -- RA do aluno
    fk_codigo_materia VARCHAR(20) NOT NULL, -- Código da matéria em que o aluno recebeu a nota
   
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA),
    FOREIGN KEY (fk_codigo_materia) REFERENCES Materias(codigo_materia)
);

-- Tabela Histórico Acadêmico (armazena o status acadêmico do aluno)
CREATE TABLE Historico_Academico (
    id_historico INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(10) NOT NULL, -- Status do aluno na matéria (Aprovado/Reprovado)
    data_aprovacao DATE, -- Data de aprovação/reprovação
    fk_RA_aluno VARCHAR(20) NOT NULL, -- RA do aluno
    fk_codigo_materia VARCHAR(20) NOT NULL, -- Código da matéria
    
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA),
    FOREIGN KEY (fk_codigo_materia) REFERENCES Materias(codigo_materia)
);

-- Tabela Frequências (armazena a frequência do aluno nas turmas)
CREATE TABLE Frequencias (
    id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
    data_aula DATE NOT NULL, -- Data da aula
    status_frequencia VARCHAR(10) NOT NULL, -- Status da frequência (Presente, Ausente)
    fk_RA_aluno VARCHAR(20) NOT NULL, -- RA do aluno
    fk_id_turma INT NOT NULL, -- Turma associada
    
    FOREIGN KEY (fk_RA_aluno) REFERENCES Alunos(RA),
    FOREIGN KEY (fk_id_turma) REFERENCES Turmas(id_turma)
);
