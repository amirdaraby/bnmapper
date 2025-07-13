# bnmapper

A lightweight Bash script to scan a list of domains or IPs using `nmap`.

---

## 📁 Project Structure

```
.
├── nmapper.sh            # The main script
├── domains            # Input file: list of IPs or domains
└── output/            # All scan results go here
    ├── example.com/
    │   └── 2025- Example Workflow07-13_14-00-00/
    │       ├── results    # nmap stdout
    │       └── errors     # nmap stderr
```

---

## 📝 Requirements

- Bash
- `nmap` must be installed and in your PATH

---

## 📄 domains file

You **must** create a file named `domains` with one domain or IP per line:

```
localhost
127.0.0.1
example.com
```

You can also add ports or options per line:

```
localhost
127.0.0.1
example.com
```

---

## 🚀 Usage

Run the script like this:

```bash
./nmapper.sh [optional global nmap arguments]
```

Examples:

```bash
./nmapper.sh -T4
./nmapper.sh -sV --min-rate=1000
```

You can mix global arguments with per-line arguments in the `domains` file.

---

## 📤 Output

Results for each scan are saved in:

```
output/<domain-or-ip>/<timestamp>/
    ├── results    # nmap stdout
    └── errors     # nmap stderr
```

---

## ℹ️ Notes

- If a domain/IP causes an error, check its `errors` file.
- Options like `-sS` or `-O` may need to run the script with `sudo`.

---

## ✅ Example Workflow

1. Create `domains` file:

   ```
   example.com
   localhost
   127.0.0.1
   ```
   or just copy from example file using following command
    ```
    cp domains.example domains
    ```

2. Run:

   ```bash
   ./nmapper.sh -sS
   ```

3. View results in `output/`

