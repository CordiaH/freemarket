# Security

## Reporting

**Do not open a public issue.** GitHub private vulnerability reporting
(Security tab → Report a vulnerability), or `security@haymarket.social`.

PGP key at `https://haymarket.social/.well-known/security.txt`.

Acknowledgement within 72 hours. This project is maintained by one person, so
a full assessment may take longer — you will get a real response rather than
silence.

## Severity here

Read [THREAT-MODEL.md](THREAT-MODEL.md) first; it defines what we claim. A
finding is severe in proportion to which claim it breaks.

**Critical — a claimed property is false:**

- Any path that gets plaintext or key material to the server
- Key substitution: a server-supplied key accepted without surfacing a change
- Downgrade to a weaker cipher suite, or forcing a group to an older epoch
- Forward secrecy failure — past epochs readable from current key material
- Post-compromise security failure — a removed member still reading after the
  epoch advances
- A member added to a group without an authenticated commit
- Cross-origin access to Freemarket key material from Haymarket

**High:**

- Metadata exposure beyond what THREAT-MODEL documents, especially anything
  linking a device to messages it sent
- Retention sweeper failing silently — data living past its window is a
  vulnerability here, not an ops annoyance
- Any bypass of group capacity or entitlement that also touches key
  distribution
- Report attestation forgeable, letting someone fabricate a moderation report

**Also wanted:** CSP bypass, SRI gaps, a path that causes the PWA to load
un-pinned code, dependency confusion in the MLS supply chain.

## Already documented, not findings

These are in [LIMITATIONS.md](LIMITATIONS.md) and reporting them as
vulnerabilities will not earn credit — though a *novel exploitation path* for
any of them absolutely will:

- Browser-delivered code can be modified by a compromised server
- The server sees group membership and message timing
- A compromised endpoint defeats everything
- Participants can screenshot and forward
- New devices do not receive message history

## Cryptographic findings specifically

We use a maintained MLS implementation rather than hand-rolled cryptography.
If your finding is in the underlying library, please report it upstream first
and let us know so we can pin or patch. If it is in our integration —
sequencing, state handling, storage, key lifecycle — it is ours, and that is
where we expect integration bugs to be.

## Disclosure

90 days or until a fix ships, whichever comes first. Faster if it is being
actively exploited, and we will say so publicly.

If a vulnerability means a claim in LIMITATIONS.md or THREAT-MODEL.md was
wrong, we will correct those documents publicly as part of the fix. Quietly
editing them is exactly the failure mode publishing them is meant to prevent.

We will credit you unless you prefer otherwise. No bug bounty budget yet.

## Audit status

Unaudited as of this writing. We will commission an independent review when
funding allows and publish the result whatever it says.

If you are a security researcher willing to look at this for a movement
project at reduced cost or pro bono, please get in touch. That is a genuine
ask, not a formality.
