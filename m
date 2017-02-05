From: Stefan Wallentowitz <stefan@wallentowitz.de>
Date: Sun, 5 Feb 2017 11:22:30 +0100
Subject: [OpenRISC] Linux openrisc init code...
In-Reply-To: <20170205084359.GD32144@lianli.shorne-pla.net>
References: <D90E780DD5090A4F9AEBC859615CED770106727209@OXYGEN.aacmicrotec.local>
 <20170205084359.GD32144@lianli.shorne-pla.net>
Message-ID: <d53290cd-697c-e45b-f964-b584e278016e@wallentowitz.de>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openrisc@lists.librecores.org

On 05.02.2017 09:43, Stafford Horne wrote:

> I haven't seen this fail before, and I haven't seen a patch before.
> Nevertheless, you are right, the architecture doc clearly says:
> 
>   R0 should always hold a zero value. It is the responsibility of
>   software to initialize it. (This differs from architecture version 0
>   which commented on implementation and that it should never be used as a
>   destination register – this is no longer specified.)
> 
> I also had a look through the mor1kx code and I cant see any place that
> r0 is tied to ground, its just another address in the register file.

I think this was inherited from OR1200.

I left it in newlib because I saw errors when simulating with modelsim
and inititalizing regs and memory to 'x. Then r0 was also 'x and the
boot failed.

Cheers,
Stefan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.librecores.org/pipermail/openrisc/attachments/20170205/7986539e/attachment.sig>
