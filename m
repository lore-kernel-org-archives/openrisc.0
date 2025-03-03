Received: from sonic311-15.consmr.mail.bf2.yahoo.com (sonic311-15.consmr.mail.bf2.yahoo.com [74.6.131.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704322611
	for <linux-openrisc@vger.kernel.org>; Mon,  3 Mar 2025 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967874; cv=none; b=k8REDHTKZOzllH5auKtKf0mcqU2OrlCOQ4fbaaO1OcmnfRMuFgpiALcOgVN5gcZbymbGh0gMraj1JNKqMPwM9qdyrvDfEUU9LS6aUQ0yj+nmedvgY4RV9qT+Cb0Z6pv4gJRiIF0NEkwKhjktRKh1XRfbMcbuPQGxx06IU+CB7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967874; c=relaxed/simple;
	bh=FtwEmGBQek6TiuRkfboxJnHVO1d0mvicCj4bgbxrlc8=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 References; b=QSpcNj7RZlakS75siHZ6ep6z6kZQisu4Z/hnrhk8ET4KZxYNRSLDs92FU6hN7imR8IH6crIE3aSWUf37QFmxkgNFIYrqkmre2h2cpdOXuwCKSqAA3tl/jiyOWQrQJ0eKQs81MNQNHJZsAavG+02eD5WvSsdLP8KTGS1w+FiXBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WkXNEmpY; arc=none smtp.client-ip=74.6.131.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WkXNEmpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740967871; bh=FtwEmGBQek6TiuRkfboxJnHVO1d0mvicCj4bgbxrlc8=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=WkXNEmpYwcPpZjtNPWaZYvxVaQlkvYsJn5e3kChgANlkdN84ZoBIc6erICO+CX3naFKzSfCu3ZhZIgHZ1wAMupsZqbAUDg2bwzB9fyAH4EmggA0pYywctdhqZp6WOcVijteR0bapAR7xuAPrQBVlJFflHx0/KMeTSaI5TgSaAXzQmmFirpG33zyX1lBmZMdv3HKYSW/lyT7tjE1LI3t6zD0C43hCW0jslHnvv5XzMcclnOr6GkY0ytpxquXUvpeytiB+tbE2U3cLzBQYzNY+a4OmhYeZdx3U6VNFmf/pWD6RUsawvGwz0/Dp79mLQNVOish09p1r/KJ3hVetovSs3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1740967871; bh=orG7hbvbMkT9P4nCcVFORM5WyMgQeOZsuS/LPUYfYcp=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=t3ChU2ocf7lwe72U4k29JRhZUx2tyWSVfgKf+0rIFkUqc++3UgtLZ51V+bJDYzBgrsbBrSGyfSGmBONLRcjMkOnPSKek8tIgsmAFwb0FN9CuhQEw/sNNCOgJW/5ynmVKoEVCs7chFRE+zt2MGF5PZzA/9tqHwfjpNZOEywkRkfANak+Wnr7bonKIYaJTKxjTycJBIWMVjhtBU3SI81PzF+UgO9kwKooADaN2qjHDcRRrBdZ0Zwvsv6WhN+qXY9KpWQXJ90Or9oAjK2hYovQ6qT0PwCy6dK75GpyPSuW5FRaOje99PNGzr7wfHBjfNUmQyUIUzQp65XGw14SUqGWqZQ==
X-YMail-OSG: M1kVobYVM1lrW_15dZcfyqvU7PhbnWNrynDvWYmexIXQaLI3xhPWLn7b3USmeyB
 TDieUVuZABIC5owpwDX3mcUt2B81MJt7eWl1ufC_oPqyTHlO2Do0FBHehsoqMBDPYo6ZLj0oaVje
 CvHplysOv4xj8_ABRA.pvgYpcN3zU8d5Cp4MAflOOQ_uESKCmV6J39o9JyXzDDc0R7qh77HY09BV
 qHxvqLY1I9DJplXJ2vl8CFtbjNbo_94mOU0Zu.30kT0F1yS5IrHtH54UGiiOKoJifNjgGxLi9Dxb
 HIIUQjGexwPoPQJ6m8Nlme.fLhWUIAVGLyIek6u8xCrzhsJFfzk6O_6tX9gfnTmSnPUf8ACFVZh1
 aDiVe4BqS6G3oILgmkR3jjsfHCpUYkq61dlii_czPhC_bsiAQlg8SuTx8i26E_xUKkgUidaT6n.K
 6diDOeiA6RlFlkq8VH_FeZoCZGkNdbi3fGUd11hCVBUve8.ef7fOP_aHfUSfk3u0wZXvUxKvO6Ob
 MO1rhixpcOkKoerrIDN7SdDx1lfCT5Cxoi2eJShuv2Nw1zan3IbXW3RWsnw01txrOIXxe2Pg.xjt
 3cW76JvC_yVYb4xXSG6YaQgJs5MI1s5FG7lsMAKLucPXjwSVhNnaIHV_rTQfJl.Ga.G_VrZT7Gih
 J7ax3J8vxw3x5po5i9iv869ogj35nrhDaIZOx3z14YUpyAntD4itZtzw4llysa5gNUSxaAbw1FQS
 dvC7W6l0Ini8aoG_kWbp300NBenNEuox4AN6iCPiVO6g82ZzHgd0kJwVGy3_wJENuIdmYtaoUzkz
 QiAYhyOhsJp.h9KxAsJLv22A1i7e4lobo_eVsCGvGG59PDkXCUChY8U0iAGzx5pMVSHzSGCqEIB_
 sfRk_49pJLzi6ZHA_uw80sk9I0RpV7AX.r2vOQRX4WsyijAdq5dbCQpFcSfj7egsJ9gT8C2CgV8H
 NaLPJ4qM_Hz9iqZqARNJyhH0wpjm1Hk2Aqf4ODwWZ5Q9bZrTfxUOqisfh_U_s9T.uWMvi4VzFJhR
 _AcNyO8O2.GjbmTtSwpHX3jqyCyab4vtsbWPJzzfyJXwQC9chO0uyyQ7FIWGOQUW_6sILBZpXR39
 P8ZhySn9kpfwSz3ls.sSGf2.5tkeVitQwoOdePNqi.TgQHSKxkp6sAMeVzw5IKQZeRcsxJHsvlLp
 yRz6ZxOoPxvIffd3FGaJ.NmqidzHRnZZ8cMuNF1LIEEW0tubGRn.CwRKf9Uz8TZvbcYq3y26yu4y
 Zjr3MTZbZwlUw6r9ZU3fwxYe1Ol8UHE6tMLdoykOhpYCsx3TcBQd8nPs91gT5P7qrZZaKSO6GkiG
 CSqOpvmNsVwUUE8J0AtkqeMkEw4u43F.78XoCX72jlfnDzeKvM2ys4PyfSdgKWBnt2i2C_tJs6QL
 8O4xjXN7sY7IoCeKvZ7Bf4g33FEYWpxzIbS9qjIMHAgS.acOx6qQuC7pJNVjqCGRVMMml_hU.A3_
 z5wfAiKloPjYGo6emf4R21FpsJ_WfnFeGugMOf6BN0gqx5ZNChDN5TUv1xdSJuOT7Pif_M7sn99R
 ELhmpg7bva_4kg8NElB4tQwnud4Wg5GMkWlZOTHlE4AFRW0KHHpgoQ6OoYGhRtZFodHYXI_RTwKW
 hdiVXqvR719yEtXj._0UBNZgmHS0KM4ddNhHBITprDK3klYbpGP5HH6i7BzTz.uwQbn0NWIEo6tX
 lvNzPAfkU4vWDJ4DZXIPOZUVJ0vuf7PUg3eUFXvMoNyPfRYMo4jof1n.zsDYQXClg1WuB_BWGyCN
 ylqCuLJ0C3_l0mmXDcczQtQK4tibHwTrPKXNOsTcwDDgmFcIGXuLrvbpaPxYlS9h8pp9TdDMRVGX
 x1X.2itg.dJlK63FVt4XWJ0xlx_NVEgzXm3arCLo6EYHHkaQnvfKtd4FYHeE2dI6myiML8vnMOWL
 pEjhHEG.kMjMeorhT48exnGM9IGG0ZfSZ5xFocRHKQTCJf.KupqtcZjgKaCIpGsD_w3ZaXg79iI9
 tQymPa7kpsP6mMANp411J9mA_v6kl8j_gbvB0guMpS6fhA.yw3Es..zJH.DADkHrcvzXCjE0JU2I
 OwtysxNBi_pKkFQDEZJKocegfLDqJUO4lttOiyUZbvWBqKNY8Xgj7HosmX3lGQHCBfwg4rLPSa1f
 bCq3vtB6HunH04NQ1KgBgQS8Qw2TYYoAa9XvnkjbdfHME7TBWkqN0cM3Q5gUflq8FvKyBdpTbCJW
 med1kV1bmjoKzhSQM.otqxJBOHhM-
X-Sonic-MF: <idzwan.nizam@yahoo.com>
X-Sonic-ID: 5e26fb43-3591-44c0-9132-08a7f6878aa7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Mon, 3 Mar 2025 02:11:11 +0000
Date: Mon, 3 Mar 2025 02:11:06 +0000 (UTC)
From: Idzwan Nizam Jamal Abdul Nasir <idzwan.nizam@yahoo.com>
To: linux-openrisc@vger.kernel.org
Message-ID: <810295975.3514440.1740967866807@mail.yahoo.com>
Subject: Performance improvements of Marocchino implementation
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <810295975.3514440.1740967866807.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.23369 YMailNodin

Hi,

I am interested in OpenRISC Benchmarking and Performance improvements task listed as one of the project ideas in Google Summer of Code. I am unable to participate in GSOC but I would like to contribute to the task gradually as I acquire skills in digital logic and computer architecture.

Is the task still open? I would be glad if you could point me to the right direction such as documentation I should read or tools I have to be familiar with. Any guidance is welcome and greatly appreciated. Thank you.
