#!/bin/sh

set -e
set -x

echo "📦 Configurando el entorno Flutter para Xcode Cloud..."

cd $CI_PRIMARY_REPOSITORY_PATH
echo "🚀 Directorio actual: $(pwd)"

echo "⚡️ Instalando Flutter..."
FLUTTER_ROOT="$HOME/flutter"
if [ ! -d "$FLUTTER_ROOT" ]; then
    git clone --quiet https://github.com/flutter/flutter.git -b stable "$FLUTTER_ROOT"
fi

export PATH="$HOME/flutter/bin:$PATH"
echo "🔍 Verificando instalación de Flutter..."
flutter doctor -v

echo "🧹 Limpiando proyecto..."
flutter clean

echo "📦 Instalando dependencias Flutter..."
flutter pub get

echo "📱 Configurando iOS..."
flutter precache --ios --no-android

echo "🔨 Configurando CocoaPods..."
if ! command -v pod &> /dev/null; then
    HOMEBREW_NO_AUTO_UPDATE=1 brew install cocoapods
fi

echo "📱 Instalando Pods..."
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod repo update
pod install --repo-update

echo "✅ Configuración completada exitosamente!"
exit 0