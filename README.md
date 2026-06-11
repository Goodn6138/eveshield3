# 🛰️ ZX303 Tracker Backend

Flask backend for ZX303 GPS tracker. Receives TCP binary data, parses packets, serves web dashboard.

## Deploy to Fly.io

### 1. Install Fly CLI
```bash
curl -L https://fly.io/install.sh | sh
fly auth login
```

### 2. Deploy
```bash
fly launch --name eveshield-thing --region jnb
# or if already created:
fly deploy
```

### 3. Get URL
```bash
fly status
```

Your app will be at:
- **Dashboard**: `https://eveshield-thing.fly.dev`
- **TCP tracker**: `eveshield-thing.fly.dev:5001`

## Configure ZX303 Tracker

### Via SMS
Send to tracker SIM:
```
adminip123456 eveshield-thing.fly.dev 5001
reset123456
```

### Via Serial AT
```
AT+SERVER=1,"eveshield-thing.fly.dev",5001,0
```
Then restart tracker.

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /` | Web dashboard |
| `GET /api/devices` | All devices JSON |
| `GET /api/devices/<imei>` | Single device JSON |
| `GET /api/raw` | Recent raw hex packets |

## Local Development

```bash
pip install -r requirements.txt
python zx303_backend.py
```

Dashboard: http://localhost:8080
TCP server: localhost:5001

## ZX303 AT Commands Reference

| Command | Response | Purpose |
|---------|----------|---------|
| `AT` | `OK` | Test connection |
| `AT+CGMR` | `ZX303.MAIN.V99...` | Firmware version |
| `AT+CSQ` | `+CSQ: 22,99` | Signal strength |
| `AT+COPS?` | `+COPS: 0,0,"63902"` | Network operator |
| `AT+SERVER=1,"host",port,0` | `SERVER OK` | Set TCP server |
| `AT+SERVER?` | `SERVER OK` | Read server (limited) |

## Troubleshooting

**Tracker not connecting?**
- Check SIM has data/airtime
- Verify APN: `APN123456 your_carrier_apn`
- Check signal: `AT+CSQ` should be > 10
- Check Fly logs: `fly logs`

**Render vs Fly.io**
- Render blocks TCP port 5001 on free tier
- Fly.io allows TCP port 5001 on free tier

## License

MIT
