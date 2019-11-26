# LS-Framework
Framework dla serwerów RolePlay w modyfikacji FiveM

## API
#### GetPlayerCharacters
```bash
GetPlayerCharacters(source)
```
Zwraca ID wszystkich postaci dla danego konta

#### PlayerIdentifier
```bash
PlayerIdentifier(type, source)
```
Zwraca identyfikator(steamid, license, ip) ex.
```bash
PlayerIdentifier("steam", source)
```

#### GetActiveCharacter
```bash
GetActiveCharacter(source)
```
Zwraca ID aktywnej postaci dla danego gracza

### Użyte biblioteki
- Lua
- NodeJS
- JavaScript