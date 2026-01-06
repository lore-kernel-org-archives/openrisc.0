Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093372EE262
	for <linux-openrisc@vger.kernel.org>; Tue,  6 Jan 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694695; cv=none; b=Iij36pA5Uo/q6+phGb7fdNQIMb6Ro641zE1VnTq4hs4RpoWPFzSL09X5tPsm5jCexR/WOuLRzDrA4C1DEOREgS7xvHoXTEYO2hdufW8yHYNu/AoS8qELkJQgW9pbzghzLeUquWKL5xo28YMZWEhLXUgC75lfmakVAynkAI8n2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694695; c=relaxed/simple;
	bh=0Ztuh7rnBiKd72hyuNM3eRD+wBpJ29KQ1CLiziiADm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBWsYew0VBfjBwLpCTg+XMltCFW5C4znnGi4H/59fE8bW0Ax02oDCMcgiKA7KX4wPPzB3V8KIwOsM7GcGH+ZU7/9rpU8nSbvlI/30NqBP5yXJkdId+gn4slZQF15IlAEZjaE49QDFZ7NQ1InoSE8QqCw8za/EwOpTvaRf4/wJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-93a9f700a8cso242793241.2
        for <linux-openrisc@vger.kernel.org>; Tue, 06 Jan 2026 02:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767694693; x=1768299493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaNnR+PjYtdzuiF4fm8ih7gsuLQAM4qtZPBAO6P24MQ=;
        b=JCULy21NcrNHMo4jLkRdGjygELVU7QP9pbeN6KBFovGzyaSV5aHfBg4134Zpx+LTSu
         imvBI1jEOvHN3XkZqrChY1HhNxFU53VLc7fR43MTacoIq7N/jldQjCRTID6SEehswXgP
         sq08msZGcERUowUpIPR52EMRsDQD5F3NmRvP1yI7RxqLcGxzEsz1pWfcNTKPhn4Ls3KC
         QX0hHDGJ3wau0tIDo2hRwvsrze+AUeaZcsE8LUDIvOx7QRAB6vknSdK0/GDxsTGsRIjJ
         StpRKXh7/JmyPOqsS8NLf+dJkl52QoY71OJnyzkwbIkbZUVqcwAmRSWtX2q4G8Bba+Fb
         wgmw==
X-Forwarded-Encrypted: i=1; AJvYcCUPnklvAP+9C80rnVAyq8g9LV22sBK6ObM/0jAWjJpv9sdSJ4Bx6Z7mvUIRzZPeCTYErwT3VVICeOoePRHPmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+t9QwDo/hJg+rxcwtRoTRiCSNYBM5oHHFKkS/S0QaPywC4kbH
	nvS7EgIfSVd7ZuA7NBhBdp/gGsacTNAJFC7x5a50xTtJEL0ReX5PjSDiNhhYvOXB
X-Gm-Gg: AY/fxX4BAnhMY9LzhUPQEHIeCA7nZ687kUlEk4O+p+M65rr9YHJDNUoBtrPAu9MF3Ud
	BQ+k4pQHzUfNFQFzglzlOyduzNOWny70UntEPNfwSp485ON+LJwMkeAg231Ik9pBG3khnYMPTox
	7xlEBrFQmZVxHJCV4NtDfFw31tOaGkS9ZkPrzejB3X/wUS+U2HSNsZrCMzJpWKTPsM/vvP6Gu2B
	cm7UEy280x6mnqWljoc7Z/ZDnK3Jr+NvcLwBfrUlo2K8muq0t09+ztLFO1HjF2MATm0zA94zSRw
	8KPVwyEceh3AxpmgDjicOiSuyoSxc+R5zmptvameXBXPuLvIPm0PuAnnwE+5IY+sWCbaCfNqECr
	ToO3IWuyrESOn3fIbItn8s8V7MfhVkkG/e2X6JBU+pMw0xVfYUVJ9Zo8UJnimqKzehocjGt20vH
	8NYWRMWNCUtKkYIZprTeLKvM0MddhDZ3sPR8u/17grkSydVjH8YOxp
X-Google-Smtp-Source: AGHT+IFm80bo3lbrvXxem9rJQiSDJb2JRl682qa7v6JXU5gANfxdMEb0G4fMwz54Zu6+J00TGxg31w==
X-Received: by 2002:a05:6102:54a9:b0:5db:417d:923d with SMTP id ada2fe7eead31-5ec744d6b17mr550408137.22.1767694692821;
        Tue, 06 Jan 2026 02:18:12 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ec7700406fsm500348137.2.2026.01.06.02.18.12
        for <linux-openrisc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 02:18:12 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b104727c8so278217e0c.0
        for <linux-openrisc@vger.kernel.org>; Tue, 06 Jan 2026 02:18:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFwH+r8lz4DKSxDysSpP7eYkF32guHqSs15CihsuafquqnqhyufwlYuZHrEBj73e7uyo9YBhaslVmkFTQa1A==@vger.kernel.org
X-Received: by 2002:a05:6122:903:b0:54a:a048:45a4 with SMTP id
 71dfb90a1353d-563395db965mr712718e0c.16.1767694692317; Tue, 06 Jan 2026
 02:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217080843.70621-1-shorne@gmail.com> <20251217080843.70621-3-shorne@gmail.com>
 <CAMuHMdVCY=5UypK65Ver6UZM_m6DZuw9mhfANMx4+Y6PgNAdmA@mail.gmail.com>
 <aVi0W6syzK6buL_v@antec> <CAMuHMdUP3z4Os=3XC6Nuzx8QAap=LTcuJrGZsy71GO=NFTOjZg@mail.gmail.com>
 <aVzb6pStdagr3IUX@antec>
In-Reply-To: <aVzb6pStdagr3IUX@antec>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Jan 2026 11:18:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXr7H_M-QO-3ty4mpycMfDHsxrDWejjw7u3RPcUqioapw@mail.gmail.com>
X-Gm-Features: AQt7F2prYcJ7L1GJNnSBejlil5cH1_t_no9UN8DCBmtBcG7ug7lF61xNlYnmN9o
Message-ID: <CAMuHMdXr7H_M-QO-3ty4mpycMfDHsxrDWejjw7u3RPcUqioapw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] openrisc: dts: Add de0 nano config and devicetree
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux OpenRISC <linux-openrisc@vger.kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stafford,

On Tue, 6 Jan 2026 at 10:54, Stafford Horne <shorne@gmail.com> wrote:
> Just curious, Do you have a quick way to enable out of tree debug patches i.e.
> to dts and defconfigs?

Keep them in your local working branch, and rebase that when upgrading?
/me has +1200 local patches :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
