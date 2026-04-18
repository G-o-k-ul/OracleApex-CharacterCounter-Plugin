# 📝 Character Counter – Oracle APEX Item Plugin

> **Plugin Type:** Item  
> **Internal Name:** `COM.ORACLE.ACE.CHARACTER.COUNTER`  
> **APEX Version:** 22.1+  
> **Author:** GOKUL – Oracle ACE Apprentice  
> **Version:** 1.0.0  

---

## 📌 Overview

**Character Counter** is an Oracle APEX Item Plugin that adds a live character counter below any **Textarea** or **Text Field** item in your APEX application.

The counter updates in real time as the user types, changing color to visually warn when the character limit is approaching or exceeded — improving form UX without any manual JavaScript on the page.

---

## ✨ Features

| Feature | Details |
|---|---|
| **Live Counting** | Updates on every keystroke instantly |
| **Two Display Modes** | "Remaining" or "Used / Max" |
| **Warning Threshold** | Configurable % before limit to show orange warning |
| **Color Stages** | Normal → Warning (orange) → Danger/exceeded (red) |
| **ARIA Support** | Sets `aria-invalid` for accessibility |
| **Max Length Enforcement** | Works with APEX's native `maxlength` attribute |
| **Zero dependencies** | No external libraries needed |

---

## 📁 File Structure

```
plugin-2-character-counter/
├── src/
│   ├── item_plugin_com_oracle_ace_character_counter.sql   ← Plugin definition
│   └── ace_char_counter_pkg.sql                           ← PL/SQL Package
├── dist/
│   └── install.sql                                        ← Combined install script
└── README.md
```

---

## 🚀 Installation

### Step 1 – Install PL/SQL Package
```sql
@src/ace_char_counter_pkg.sql
```

### Step 2 – Import Plugin into APEX
1. **Shared Components → Plug-ins → Import**
2. Upload: `src/item_plugin_com_oracle_ace_character_counter.sql`
3. Click **Next → Install Plugin**

### Step 3 – Use on Your Page
1. Add a **Textarea** or **Text** item to your page
2. Set **Type** to: **Character Counter [ACE]**
3. Configure attributes below

---

## ⚙️ Plugin Attributes

| Attribute | Type | Default | Description |
|---|---|---|---|
| **Max Length** | Number | `500` | Maximum allowed characters |
| **Display Mode** | Select List | `remaining` | `remaining` = shows chars left; `used` = shows used/max |
| **Warning Threshold (%)** | Number | `20` | At what % remaining to turn orange warning |

---

## 📸 Counter States

| State | Color | Example Text |
|---|---|---|
| Normal | Gray | `450 characters remaining` |
| Warning | Orange | `45 characters remaining` |
| Danger | Red Bold | `0 characters remaining` |

---

## 💡 Use Cases

- 📋 **Comment / Notes fields** with database column length limits
- 💬 **SMS or short message** composers (160 char limit)
- 📧 **Email subject** fields (78 char recommended)
- 📝 **Bio / description** inputs in profile forms

---

## 📄 License

MIT License – free to use, modify, and distribute. Attribution appreciated.

---


## 👤 Author

**GOKUL**  
Oracle ACE Apprentice  
GitHub: https://github.com/G-o-k-ul
Blog: https://codewithgokul.blogspot.com/
LinkedIn: https://www.linkedin.com/in/gokul-b-ab86a6229/