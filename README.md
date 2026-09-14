# Freemarket

End-to-end encrypted messaging for [Haymarket Social](https://haymarket.social).
Haymarket is where you organize in public. Freemarket is where you talk behind
closed doors.

**License:** AGPL-3.0-or-later · **Status:** pre-launch, unaudited ·
[Limitations](LIMITATIONS.md) · [Threat model](THREAT-MODEL.md) ·
[Security](SECURITY.md)

---

## Read this before you trust it

Freemarket is end-to-end encrypted using MLS (RFC 9420). It is also a web
application, which means **our server delivers the code that does the
encryption**. A compromised or legally compelled server could serve modified
JavaScript that leaks your keys.

We mitigate this — separate origin, strict CSP, subresource integrity, an
installable PWA that does not re-fetch code on every load — but we do not
solve it, and no browser-delivered messenger does. Signed native binaries
close this gap. We cannot.

**If a compromised server is a realistic threat in your situation, use
Signal.** We would rather lose you to a better tool than keep you on a
promise we cannot keep. [LIMITATIONS.md](LIMITATIONS.md) is the full list,
and it is published in-product, not buried here.

What Freemarket is good for: everyday organizing conversation that should not
be readable by us, by an advertiser, by a scraper, or by whoever ends up
owning the servers in ten years.

## What it does

- **MLS (RFC 9420)** group messaging, which scales to real group sizes rather
  than degrading like pairwise ratchets do
- Forward secrecy and post-compromise security through epoch advancement
- 1:1 and small groups free; larger channels under an organization
  subscription — the paywall is on capacity, never on encryption
- Report-based moderation, because a server that cannot read messages cannot
  scan them

## What it deliberately does not do

Each of these is a decision, not a gap:

- **No sender recorded on stored messages.** MLS authenticates the sender
  inside the ciphertext. The server never needs to know, so it does not, and
  "every message sent by X" is not a query this database can answer.
- **No presence or last-seen.**
- **No read receipts persisted server-side.**
- **No server-side message search or indexing.**
- **No message history sync to a newly added device.** Forward secrecy means
  old epochs stay closed. This is a feature that looks like a bug.
- **No cloud backup of keys.**

## Why a separate repo

Not just tidiness. This code has a stricter review bar than product code and
needs to be auditable on its own — "what changed in the encryption layer this
quarter" should be one `git log`, not an archaeology exercise. It also has a
separate origin and a separate deploy pipeline for security reasons, so a
separate repo matches how it actually ships.

## Stack

MLS via a maintained implementation — no hand-rolled cryptography, ever ·
Postgres via Supabase for ciphertext and the minimum routing metadata ·
Deployed as a PWA on its own origin

## Development

```bash
npm ci
cp .env.example .env     # beta credentials only
npm run dev
```

## Contributing

[CONTRIBUTING.md](CONTRIBUTING.md) first — the rules here are stricter than in
the main repo, and the cryptographic layer has its own. Contributions require
a signed [CLA](CLA.md).

## Security

Do not open a public issue. [SECURITY.md](SECURITY.md).
