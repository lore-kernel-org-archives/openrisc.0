From: Rob Herring <robh@kernel.org>
Date: Thu, 8 Apr 2021 15:08:00 -0500
Subject: [OpenRISC] [RFC PATCH v6 1/1] cmdline: Add capability to both
 append and prepend at the same time
In-Reply-To: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
References: <34d20d1dbb88f26d418b33985557b0475374a1a5.1617556785.git.christophe.leroy@csgroup.eu>
Message-ID: <CAL_JsqJ=UNfptbNHR5XAS9BQRv3C5+YonW9rwypA5gGt2N7bGQ@mail.gmail.com>
List-Id: <openrisc.lists.librecores.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openrisc@lists.librecores.org

On Sun, Apr 4, 2021 at 12:20 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> One user has expressed the need to both append and prepend some
> built-in parameters to the command line provided by the bootloader.
>
> Allthough it is a corner case, it is easy to implement so let's do it.
>
> When the user chooses to prepend the bootloader provided command line
> with the built-in command line, he is offered the possibility to enter
> an additionnal built-in command line to be appended after the
> bootloader provided command line.
>
> It is a complementary feature which has no impact on the already
> existing ones and/or the existing defconfig.
>
> Suggested-by: Daniel Walker <danielwa@cisco.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Sending this out as an RFC, applies on top of the series
> ("Implement GENERIC_CMDLINE"). I will add it to the series next spin
> unless someone is against it.

Well, it works, but you are working around the existing kconfig and
the result is not great. You'd never design it this way.

Rob
