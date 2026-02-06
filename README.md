# Flex Docker Environment

Docker environment for [flex](https://github.com/westes/flex) (Fast Lexical Analyzer) built from source.

## Getting Started

### 1. Build and start the container

```bash
docker compose up -d --build
```

### 2. Enter the container

```bash
docker compose exec flex bash
```

### 3. Run the example

```bash
cd /workspace/examples
flex example.l
gcc lex.yy.c -o scanner
echo "Hello World from flex!" | ./scanner
```

Output:
```
Lines: 1, Words: 4, Characters: 23
```

### 4. Stop the container

```bash
docker compose down
```

## For Students

Create your own folder inside `workspace/examples/` with your name or project:

```
workspace
├── juan
│   └── scanner.l
├── maria
│   └── tokens.l
└── proyecto1
    └── lexer.l
```

Inside the container, navigate to your folder:

```bash
cd /workspace/examples/tu-carpeta
flex tu-archivo.l
gcc lex.yy.c -o scanner
./scanner < input.txt
```

## Useful flex Commands

| Command | Description |
|---------|-------------|
| `flex file.l` | Generate lex.yy.c |
| `flex -d file.l` | Enable debug mode (prints each token match) |
| `flex -v file.l` | Verbose output (shows DFA stats) |
| `flex -o output.c file.l` | Custom output filename |

## File Structure

```
flex-docker/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── .gitignore
└── workspace/
    └── examples/
        └── example.l
```

## Notes

- Generated files (`lex.yy.c`, `scanner`) are excluded from git
- Only commit your `.l` source files
- The container includes `gcc` for compiling the generated C code