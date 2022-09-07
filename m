Return-Path: <openrisc-bounces@lists.librecores.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.librecores.org (lists.librecores.org [88.198.125.70])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24938C54EE9
	for <openrisc@archiver.kernel.org>; Wed,  7 Sep 2022 14:44:33 +0000 (UTC)
Received: from [172.31.1.100] (localhost.localdomain [127.0.0.1])
	by mail.librecores.org (Postfix) with ESMTP id B45C1247FD;
	Wed,  7 Sep 2022 16:44:32 +0200 (CEST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com
 [209.85.128.180])
 by mail.librecores.org (Postfix) with ESMTPS id 2CACB248F9
 for <openrisc@lists.librecores.org>; Wed,  7 Sep 2022 16:19:50 +0200 (CEST)
Received: by mail-yw1-f180.google.com with SMTP id
 00721157ae682-344fc86d87cso114585447b3.3
 for <openrisc@lists.librecores.org>; Wed, 07 Sep 2022 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=xzQQge1p9sGh6RMu1G1JOY9ItCc6O0H120k6pKHMmEk=;
 b=Bih6yKcvqhH4zWrwdr6CGGO42qojshsT47RQnhXv7ybu5CD6vL27DQnoZCdIiZcqnD
 0MNFx49OnNcHRuNt0yer8KsEpHqlebpbukHR8/U0Knhm5IkCoZC+cpXtWgtCriZjynid
 t5Bruq5/CLUqLGLQKdHNGqoXOR5/u+8UPkJ82rmSO8YnBjZPRRwCZiKEUE1IWXZHpGhw
 3GuaMXYCxJXztaV0qrqOzBvSR3aM+i2HSRfZe2zbCTl0yZUnpl7Hk5ecvH5V+LsTxI6l
 HjAU7bKenJs8zPJhJgMQUWxJQCh6oc6moTNqrwTOfD2LY0IITD2J+XO/28stoTLZrTY6
 X8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=xzQQge1p9sGh6RMu1G1JOY9ItCc6O0H120k6pKHMmEk=;
 b=4h9rswwZx1Tiw3zCuoUwA67BrFavUNlibXb6U3olv1nlPwDw8axukGfdN/5mtcbndP
 /EhuhJIQF6SvaL1kE9HAn8n1sNwhQ/RncUCwg5/PhvBzb2oI9Ydzgg6a2KmiSlrMbdYt
 C7iN8FyT5ar9GaRy+vt4U6qef5seOGwOlqspk+bp5ShHYVSvvgccpWonzTFfJgvCyAZq
 DDZfolrouPtrpVMnRiMChUBfvWpBpnyQAJLvL6dTX/cXf8Uu82IQv41z2As/ilsOOE/N
 ZRp6jtSvx4uppi+4/C9AMOxqt090H96FbaDSIdaEbkAVpKJMNFLUKNNI3oJoe6CS2dTK
 f4Gg==
X-Gm-Message-State: ACgBeo18Z+nEJ79YHw4/RZ/dYM8ndwcnSjnBIaGQgObupmVxHEXYxZ93
 ga7Igk2iStVaI9SBoydqCrFgjHqtbcmdQtsh3co=
X-Google-Smtp-Source: AA6agR6es1m2QTKoQhG3HmhDk7/mGxawhEgjnpT++W2R7RDp8RxAnyCjkeWxHPwQeUEm0Uw6m26keN7xYXBr3V6AeCc=
X-Received: by 2002:a0d:cc83:0:b0:345:14a5:a2b0 with SMTP id
 o125-20020a0dcc83000000b0034514a5a2b0mr3532402ywd.206.1662560388878; Wed, 07
 Sep 2022 07:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220904072607.44275-1-shorne@gmail.com>
In-Reply-To: <20220904072607.44275-1-shorne@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 Sep 2022 10:19:37 -0400
Message-ID: <CAJSP0QVnMFjodM26-ehXi0Yd9eiBHJXJwBudJqyQg8a3j6rJCA@mail.gmail.com>
Subject: Re: [PULL 00/11] OpenRISC updates for 7.2.0
To: Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 07 Sep 2022 16:44:31 +0200
X-BeenThere: openrisc@lists.librecores.org
X-Mailman-Version: 2.1.26
Precedence: list
List-Id: Discussion around the OpenRISC processor
 <openrisc.lists.librecores.org>
List-Unsubscribe: <https://lists.librecores.org/options/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=unsubscribe>
List-Archive: <http://lists.librecores.org/pipermail/openrisc/>
List-Post: <mailto:openrisc@lists.librecores.org>
List-Help: <mailto:openrisc-request@lists.librecores.org?subject=help>
List-Subscribe: <https://lists.librecores.org/listinfo/openrisc>,
 <mailto:openrisc-request@lists.librecores.org?subject=subscribe>
Cc: openrisc@lists.librecores.org, qemu-devel@nongnu.org
Errors-To: openrisc-bounces@lists.librecores.org
Sender: "OpenRISC" <openrisc-bounces@lists.librecores.org>

On Sun, 4 Sept 2022 at 03:27, Stafford Horne <shorne@gmail.com> wrote:
>
> The following changes since commit 61fd710b8da8aedcea9b4f197283dc38638e4b60:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2022-09-02 13:24:28 -0400)
>
> are available in the Git repository at:
>
>   git@github.com:stffrdhrn/qemu.git tags/pull-or1k-20220904

Hi Stafford,
Please update .git/config to separate the push URL from the fetch URL:

[remote "github"]
        url = https://github.com/stffrdhrn/qemu.git
        pushUrl = git@gitlab.com:stffrdhrn/qemu.git

That way future pull requests will include an https URL that allows
fetches without ssh or a GitHub account. Thanks!

Stefan
