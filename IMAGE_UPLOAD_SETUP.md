# Image uploads (banners, profile photos)

## What this app uses today

The **server** uploads images to **Cloudinary**, not Google Cloud Storage.

Config lives in `server/.env` (see `server/.env.example`):

```env
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

Get those from the [Cloudinary dashboard](https://cloudinary.com/console). Restart the server after saving `.env`.

No GCP / IAM JSON file is read by the current codebase.

---

## About `wonderport-496922-84c3bb3f03c9.json`

That file is a **Google Cloud service account key** (project `wonderport-496922`). It is for GCP APIs (Storage, etc.), **not** wired into this repo’s upload flow.

### What you should do

1. **Do not commit it** — keep it local only; it is listed in `app/.gitignore` as `wonderport-*.json`.
2. **Do not put it in the Expo app folder** for production builds — mobile clients should never ship service account keys.
3. **If the key was shared or committed anywhere** — delete that key in [Google Cloud Console](https://console.cloud.google.com/) → IAM → Service Accounts → Keys, create a new key only if you still need GCP later.
4. **For this project’s images** — use **Cloudinary** in `server/.env` (above). That is what `server/src/helpers/uploadToCloudinary.ts` uses.

### If you wanted GCP instead of Cloudinary

That would require new server code (e.g. `@google-cloud/storage`) and env like:

```env
GOOGLE_APPLICATION_CREDENTIALS=C:\path\to\key.json
GCS_BUCKET=your-bucket-name
```

That is **not implemented** today. The wonderport JSON does nothing until you build that path.

---

## Checklist

- [ ] Cloudinary account created
- [ ] `server/.env` has `CLOUDINARY_*` filled in
- [ ] Service account JSON stays **outside** git (local path only, or delete if unused)
- [ ] Server restarted: `cd server && pnpm run dev`
