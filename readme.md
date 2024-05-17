# Docker Example App

Bu proje, Docker kullanarak basit bir Node.js uygulamasının nasıl oluşturulacağını ve çalıştırılacağını göstermektedir. Ayrıca, GitHub Actions kullanarak Docker Hub'a otomatik olarak nasıl image push edileceğini de göstermektedir.

## Başlarken

Bu talimatlar, projenin yerel makinenizde nasıl çalıştırılacağını anlatır. 

### Gereksinimler

- Node.js
- Docker
- Git
- GitHub hesabı

### Kurulum

Proje dosyalarınızı klonlayın:
```bash
git clone https://github.com/username/docker-example-app.git
cd docker-example-app
```

Node.js bağımlılıklarını yükleyin:
```bash
npm install
```

### Uygulamayı Çalıştırma

Node.js uygulamasını başlatmak için:
```bash
node app.js
```

Tarayıcınızda `http://localhost:3000` adresine giderek uygulamanın çalıştığını kontrol edin.

### Docker Kullanarak Uygulamayı Çalıştırma

1. Docker image'ınızı oluşturun:
    ```bash
    docker build -t username/docker-example-app .
    ```

2. Docker container'ınızı başlatın:
    ```bash
    docker run -p 3000:3000 username/docker-example-app
    ```

Tarayıcınızda `http://localhost:3000` adresine giderek uygulamanın çalıştığını kontrol edin.

### GitHub Actions ile CI/CD Kurulumu

1. GitHub'da repository'nizi oluşturun ve bu repository'yi yerel makinenizdeki proje ile bağlayın.
2. GitHub Secrets ayarlarını yapın:
    - `DOCKER_USERNAME`: Docker Hub kullanıcı adınız
    - `DOCKER_PASSWORD`: Docker Hub parolanız
3. `.github/workflows/docker-image.yml` dosyasını oluşturun ve aşağıdaki içeriği ekleyin:

    ```yaml
    name: Docker Image CI

    on:
      push:
        branches:
          - main

    jobs:
      build:

        runs-on: ubuntu-latest

        steps:
        - name: Checkout repository
          uses: actions/checkout@v2

        - name: Set up Docker Buildx
          uses: docker/setup-buildx-action@v1

        - name: Login to Docker Hub
          uses: docker/login-action@v1
          with:
            username: ${{ secrets.DOCKER_USERNAME }}
            password: ${{ secrets.DOCKER_PASSWORD }}

        - name: Build and push Docker image
          uses: docker/build-push-action@v2
          with:
            context: .
            push: true
            platforms: linux/amd64,linux/arm64/v8
            tags: username/docker-example-app:latest

        - name: Logout from Docker Hub
          run: docker logout
    ```

4. Workflow dosyasını commit ve push edin:
    ```bash
    git add .github/workflows/docker-image.yml
    git commit -m "Add GitHub Actions workflow for Docker image"
    git push origin main
    ```

Bu adımlardan sonra, her `main` branşına push yaptığınızda GitHub Actions otomatik olarak Docker image'ınızı oluşturacak ve Docker Hub'a pushlayacaktır.

 