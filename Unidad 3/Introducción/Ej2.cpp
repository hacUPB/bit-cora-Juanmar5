void swapPorValor(int a, int b) {
    int temp = a;
    a = b;
    b = temp;

    cout << "Dentro de swapPorValor -> a: " << a << ", b: " << b << endl;
}

void swapPorReferencia(int &a, int &b) {
    int temp = a;
    a = b;
    b = temp;

    cout << "Dentro de swapPorReferencia -> a: " << a << ", b: " << b << endl;
}

void swapPorPuntero(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;

    cout << "Dentro de swapPorPuntero -> a: " << *a << ", b: " << *b << endl;
}

int main() {
    int x = 5;
    int y = 10;

    cout << "Valores iniciales -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorValor(x, y)" << endl;
    swapPorValor(x, y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorReferencia(x, y)" << endl;
    swapPorReferencia(x, y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    cout << "\nLlamando a swapPorPuntero(&x, &y)" << endl;
    swapPorPuntero(&x, &y);
    cout << "Después -> x: " << x << ", y: " << y << endl;

    return 0;
}