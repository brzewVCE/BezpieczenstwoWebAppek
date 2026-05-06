# BezpieczenstwoWebAppek

## Opis projektu
Aplikacja jest dostępna pod adresem [http://localhost](http://localhost). 

Projekt zawiera zautomatyzowany proces wdrażania aplikacji bWAPP. Tradycyjnie bWAPP wymaga ręcznej instalacji poprzez skrypt `/install.php`, jednak w tej konfiguracji proces ten został w pełni zautomatyzowany wewnątrz kontenerów, co pozwala na natychmiastowe rozpoczęcie pracy po uruchomieniu środowiska.

## Konfiguracja
Parametry bezpieczeństwa i działania aplikacji można konfigurować za pomocą pliku `.env`.

### Zmienne środowiskowe
- `RATE_LIMIT`: Średni limit zapytań na sekundę dla jednego adresu IP (np. `5r/s`).
- `BURST_LIMIT`: Maksymalny rozmiar bufora dla nagłych skoków ruchu (np. `10`).

## Docker
### Włączanie
```bash
docker compose up --build -d
```

### Wyłączanie
```bash
docker compose down -v
```

## Testowanie i weryfikacja

### Ochrona przed atakami Brute-force
Aby przetestować działanie mechanizmu rate limitingu, możesz użyć poniższej komendy, która symuluje szybką serię zapytań:

```bash
for i in {1..20}; do curl -I -s -o /dev/null -w "%{http_code}\n" http://localhost/; done | sort | uniq -c
```

**Interpretacja wyników:**
- Kod `200` lub `302`: Zapytanie zaakceptowane.
- Kod `429`: Zapytanie zablokowane (osiągnięto limit).
