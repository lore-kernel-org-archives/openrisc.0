Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2333F1FC0E6;
	Thu,  5 Jun 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115524; cv=fail; b=uC5OpFsgq3o7s/syCzXloHyEuLhlMT1oWZyGIWW2KF+ej6ZZfF8z3qe3Jf/yF5PM5rnLQBGNzRmRuvmhMOi2KEj2uD5qT0J9dAG7d3vSQGO3sCxawAYeuLiFzhQwmwdt9x9rnN4zi2Z74hLIVtrpEnd9iqHqwu5VVPlX2yUufc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115524; c=relaxed/simple;
	bh=5rimCqAeVNWODl1lfkvcXArEhZowYbd0U0DzXbk+KAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gZDftJxwW29QYVveud/VVQI1muIjK+a5gzpCkdB9CBACbOUaqp1sxV9F0oaBXnTETmUEG+hBgbtmTbEuBLqL7InjJNMAJ4qS4sH4VqquzVoN99FmXAPDBjFcAwsfo5BkvG/+Wx5Qnp/FenlkDYdKQ59l7f0TLlumq2zpYh5py/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h472MX6u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yCC4qAkO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h472MX6u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCC4qAkO"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5554vGZ8004980;
	Thu, 5 Jun 2025 09:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mYa3EmwjX3KR/pLvWS
	a6CqnXqCvQ2hUOVdZtX+XGaDU=; b=h472MX6usPReO+Tzwsxm48Imtzm1wihJBj
	NJhzTqboYr4UQoifou3W8K5FGrx2+n7L77KNmho/Sv6ksv8Z8UIeTV7ciMEpS+H5
	NiKWF1bJ9dKLDMiIxvRVfd4p6gIHmknKQIE2YsE/hV0ESxrjdCLaY52MEZisLxAl
	buSAQbJNhjz1PdZqm22v8i6OeqbG2RZxfTGy9eixvxYrJgPgo0GSq/yWP0VLu8CH
	+MXL01WXTCgzr2HaOr2Uf4PtBb/YwYqKYmEMbCO1X/FCE67EgwEsBClZQZLV92cf
	ESrNLIaaWPk13FeEI48wlXoGTOaW/A6JH1jXaRmk3d12xByEihGQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gwhdmh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:24:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5558CQGd030722;
	Thu, 5 Jun 2025 09:24:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7bukhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 09:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5fdyTkAAuUwmJTzdUBwOc67agaz4ppfodbS998M44NGei8/X9uQcYn866eUBG4DxdScNXUeLFUqvHDOcM6AQPxjOj4+BQcvZL5RzBQi2OEdnOQwe24lA+vn2s/m6WRsQV+m3DHw/ZVGZXZ1zX+69z39whk3E/6eUDg2DArBa/xUDghIMfcwndh9hR3oekUXJbygIwcn2Zncfy4EjlfQA6Xq3wDOevJ2ql4OL6Nz6Kdnn6+DPDNP1fKWVzhGk/0+CgxnjNSxQ3qFctKSVdfOKRzZ3b8haCpI0sW49R57HInXWXUMEekpL7gOlSRCpcZCDucWufcknzBaYuQv5rhsnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYa3EmwjX3KR/pLvWSa6CqnXqCvQ2hUOVdZtX+XGaDU=;
 b=ozL+5iWSz5GZkgHno1sQNGnZzKDvIDTb7Tg4dkC2xgi8iwZTyU+T2G3Bsn34Ig1u3ryCW5freZliN+emfX2mzM9LdkKWWkjlAs5oJvuBnJ9B+egCRN9RTNme/0AR+HU6ybKMn+mcAdZ6qAUm64kn+gOGFqDWjq5auoROthGLTHvwAUl1kvFtp3+GwzG+RBTXJkwNGzCWkNiZCz+yUrrQSwFD0aM5ATcaHJ2d0mTsT7e94s2v6gKHsYpq8T+Mt7XhUhjMclz370mNPXAAvCGQuC53QIUDegGMrMWMZLc+OtSQIM9XVrip3SipqshhlXmnMohydwkgElc1KBaUal9R/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYa3EmwjX3KR/pLvWSa6CqnXqCvQ2hUOVdZtX+XGaDU=;
 b=yCC4qAkOAw/mzeMnpMyWJFLoxmJrNFmH+shaYnpovZyy0g6EYEkvIb2Hq8kf5ALdxTBB5F9/Am6QJENJHvSr8sYC9MIqtvmyLBsRXYiTkVH9tMBnAXfj3w7mNdSZVmaKecf2cBnUeUys3B1t7WJG2FeMMSfr2Erxmb2x2bZLkwI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 09:24:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Thu, 5 Jun 2025
 09:24:27 +0000
Date: Thu, 5 Jun 2025 10:24:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jann Horn <jannh@google.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/pagewalk: split walk_page_range_novma() into
 kernel/user parts
Message-ID: <5a06f383-7d01-4ea7-a010-013063770240@lucifer.local>
References: <20250604141958.111300-1-lorenzo.stoakes@oracle.com>
 <536f5ffd-b4cf-4f35-970c-ad3a7593af2f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536f5ffd-b4cf-4f35-970c-ad3a7593af2f@suse.cz>
X-ClientProxiedBy: LO6P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 13734f74-bb83-4fd0-cd05-08dda412c4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DE2goMQHooLIg+Zz7uLwKtMCZ/embgW0t0Ul5CjViRkv0/OK4YcJtNoxJNY7?=
 =?us-ascii?Q?bUUW+fn/QyTsxoDCf1v+iFYNNV7H7yrHUzvwd249UMcf2QKEKWLc0CDlDXC3?=
 =?us-ascii?Q?ZMsF/+w9NucZDDRun/fQNmvPEy/6JI10YxRklTqLTpKnPsNJRMIYp3So378A?=
 =?us-ascii?Q?dxc9btehghw5dkQyMoC+N5ysn4R16f7zqI/SdFr8sqISV0aGOTnZLjojlCkD?=
 =?us-ascii?Q?d4m8DiSe/LvoKbQypkfbX2ee32wGRugYjLpY/XaeF6NYi7lKMsv0XzO1zcpd?=
 =?us-ascii?Q?Zh+Zm6THn0g0Dc0wvhfwuVCWHi0SME79ZbmudE2dFyEm2gnsgKlMbA1Bfdeb?=
 =?us-ascii?Q?rsnwgF1tOhtdxWO3Riq52DWdEctfSZtW/L9ipZMymWabkkN7r70wGoOzoUZL?=
 =?us-ascii?Q?+I9aUd/neEv4CAG18LWLsowbRSIHF8ApqHcjSkLUMooFmRuPgkgW8nxqKPqL?=
 =?us-ascii?Q?R+Pr/di3pfiUReHSfue1CmxdY9PkoyQh5fzafVeXE27WapWcCo0H1dXq17Dx?=
 =?us-ascii?Q?62bl4fyYbJhEZ4EpFM/DWZXH8BUAEOm1y2S996ew4pR2O/VLqV+0ZmzhC4aw?=
 =?us-ascii?Q?zMGjem8IV6Opu+38vhSTSsvle4DL5JMuZecbJW4yLaV8lVSIxItN3JCbuES2?=
 =?us-ascii?Q?hZA8oLVPjQrBUyPubTzxl8+d7aq6Mb0vLStWb9IOJeO9MYUmdgoh7lgVcYs4?=
 =?us-ascii?Q?VX80o8tMOx/KQGIrAyvh91BXrH/Wt7LurAhJrNLtJ+1KgVMIoQlPCbyoUDZB?=
 =?us-ascii?Q?O6VnSUe/Zd4PvN4HI/uT27QjYFZaXsfgHri23JxYfnHZqECTxeJidm3PVIgL?=
 =?us-ascii?Q?B4fbFPtCfl3g8RK+D5o1Sc/0Cig0zpFJb8Y70z6h800FxH3GdqqC7REtMDfZ?=
 =?us-ascii?Q?Ep5hemA9Mc6H3S7FtN8SA5k5IlPXmFxPohqBi6ZQ2ipWgp+58SuyUwCqfT6p?=
 =?us-ascii?Q?CrLnnTn1C94tUPCnj7oY9Bzgb6duHOLAqI/SruPWRHtk6oPzyqblHRl9ZQp9?=
 =?us-ascii?Q?Hr7EjtMpBV7kL2p2F5RXVRvDK8yBALR19u/mttAckUYQAbbHZdWJATjkInEg?=
 =?us-ascii?Q?8qlLd48fwX3MOYGzKXif20Ia45zXO8n1U1eVfPi9gStLEodhzN6SlyljsvUY?=
 =?us-ascii?Q?WqbjmBgkW7nUcL3j2WqBwjr13wwE60o9wfG6koUufY+aR+/+/dX6kDpevIFs?=
 =?us-ascii?Q?SxjjPkYwkSHSlAnbt2w+G7JhyE8fRWzT0PdQq8emoAp3yPUiMFevNB9Z6LIk?=
 =?us-ascii?Q?2YZI4F+GlP+f33UPd6Ad3sF3G+x3ludDZJm6ib3YNJzY0vM43t4Ew08ns0jE?=
 =?us-ascii?Q?13fNtwNEblhS9TKwy5d2K0bPklNu6PXizcIVH96TapoYw+0ie8gPSapTs5kT?=
 =?us-ascii?Q?qkPPqsSCbOMeHybphd0D6S++Kajf1temA1s1UYrGPV1/8TtHiaRU/+lh57/f?=
 =?us-ascii?Q?VidOcO/j/4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRZDadQAUwJU48QjQagNo4/Ue0b/G4fGaskialJC3AIXKav9y1iz0gLYC3IY?=
 =?us-ascii?Q?UQYtT6udDpjTOxSdPcPpSbEHYwlQVZ4Q7am391W7DfLtAcBa66IGRXq5l17k?=
 =?us-ascii?Q?0tvngG5CSLzldwQy/jEgtyiPdf09O6BuiwpHvqV1cXXXSO4OftIYoD9jmhFT?=
 =?us-ascii?Q?bEsZjA1uyaqVnDWBXxazNQLQnNNb1iyULtqNqIj98zydwNba/HPr3O9c010c?=
 =?us-ascii?Q?Ndg233qfx9gA8nzb3UTGdH61KAqWCghnLncSZYQ2lwg2ehfsTiTXPTEdQzfo?=
 =?us-ascii?Q?rgzoq243Pg4rYjZyY9qcSBLd//T7SPrb4a9wDsTYcBjnLreane5IYJxfb80K?=
 =?us-ascii?Q?7wMEKwbn0gVqMEOuclxpufWHCwISbZt3k7iJYG5yLaQQqB/PTwkObQ+TOTVp?=
 =?us-ascii?Q?WsJOH0k+h8MDU8jGYWn4i/rP6SFhp4E4h968954uHUX80Hp1l756d0I3zGOP?=
 =?us-ascii?Q?CWqQav6mriN3nCfM0nMPIf5REnEyRfYyg+t8WJwWudVhD0ugnEWtTG4SnlTE?=
 =?us-ascii?Q?U4L9NCu2bW6IH3pn61w85+F7NJwgeR3JPxP01+TSz6hmQRuSm9ao7hNk4wZh?=
 =?us-ascii?Q?ZtwVpEVrMz2GaHj/irGgJySjX/RWiM0QAMfy3TS2pc32gIxFwKz7ZQxwe2Eo?=
 =?us-ascii?Q?ib+e9mXGIasMA3u+y/g5T02G3GWedNQbMpSVLakt4C1eQ7lajFJesVwWEtSc?=
 =?us-ascii?Q?R1/5HSo9GgCSC/AYp4NgKz90nwkwRzZQOXz+K76qrmL8e0a6QvDdvojyodGY?=
 =?us-ascii?Q?kMSdMEgSNue2m9/s2O1r4lgoTFJ217sHTjebYHCAVIUUUlJ2VoMu8aJbMl2r?=
 =?us-ascii?Q?SWHsyKUGQWrQfJuK4Y/bY01vFcUGA8waVkfenNco0iJcWomGSrX32vzcwH2H?=
 =?us-ascii?Q?tfDjn907o6XuS8qXFUE3ihlz7aOcD8ie2/1ePmPlrbQI6idD+oKQHaD88AjN?=
 =?us-ascii?Q?MSVXVKTRl3YqlWk50nvxyvLSJlqvI+8/8XRMw68glL+c8G6ucFbJ60syxDmW?=
 =?us-ascii?Q?gilmgUrkDZtXLmX8WPXk80ReS/ki95UlKn40KpgBQB9YkAKgtOWJW5cFQZJ2?=
 =?us-ascii?Q?9t+gFMOScKNYgcHaCKpgICesSL9nicQVRP6j9bZUWMUeSOv1TWqCGvSEMDPU?=
 =?us-ascii?Q?azmQBOiG38RNOpveMWtKzbRCscuoMQG9jPJSXO1F23JtK0+eU/VtdO1de2Yj?=
 =?us-ascii?Q?8ht0AdTZPqSs6aPCB4vbn5dCYZqxsQJs3TpGLTy3gucajmXEKolDAR4y7umL?=
 =?us-ascii?Q?ntMeFxxM+1QqhO3Th7G2yyxX47VQyiokrJZ3BrJRF6P+/3mBBqRyJGm/9/Ud?=
 =?us-ascii?Q?iPBmmRY4AMubEOyfdIsrjLaLZbK27WHCZOicjXd21jQN4ZDCKQn3TayH+xKm?=
 =?us-ascii?Q?lwU06/EsDysky91CdBovYWN8TiMsEC9lj+hJ1xzqnF1KBAnf2As9yc99vQmB?=
 =?us-ascii?Q?ZR2oLvW/JhliiWuuJbvBcb0omYP2qld8TpkL4MHY4X9Djk0hrva9GeLEO+Gf?=
 =?us-ascii?Q?fhAEgu9kpIBq+rtXa1jD9ZRQK728jF4JWOnVPqm5VtZL9l7Pss2dQostJ4H5?=
 =?us-ascii?Q?CwMsFvgZkc4JN401W367AbPL5BsyEUQBO+TvTvaDshNBi5vDDFFH8+n9gNr2?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b4gTiU54czjmgFxuVnKs3fkhrgq7thxnjIFZfiMWZ0IIcqAac9WUWhvdmABA23wHRWYZtHfGwZYvyKcaBAjmQcPy7tmNb+KNHWATXhi/QpOEmeQfZ2IyDX0ytyvmjKcNhNaQ27O1gD9ucc8212s57HgjEdi7+XH55e1E2/r35NfL8PK2ezNYJ5K1CZLcdPP9dOgQPOEl35MZrUvhs/juWcOc4W58ztr2+sy2u8y2mHBNGzpdf8TtQpfA5+E8RvmWGt2qFRG08zk+p2yURkP37v/yOtQHKLQuFbqxL4JMnQX5Hp8CYIqUsmBL45ZgKIcPebLrowUpM6mf7bYUsMd7lnyz2i1gvL2YpeDEwlUScpM0shQT9CgizaXn4ipva7Bin6SqueCXFIcrmOeMgCpNXr1oWCfMZfZuka9zwAaJmYTFvL6oOImxgVoIC/LkAUcVnEsKYJikF1L+9kyUw8l9Li/1hY/7JNk5upTr1LO/ooFxQW4Th+UdJIIhIkSD1HGHGu60x7YpQ32kuyGgi/Gd57xKh6blqo69fdpBODt2JbqJMnnuO9YJCFMkOU0RTMl1AliOkrT4gGlKigUesswxSzHJA73/46gqZQ1MHFoWalU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13734f74-bb83-4fd0-cd05-08dda412c4e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:24:27.7160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn89SUvLq+suUPbkUV2vkwKlDNPt6dclnTY8xO/je02yUOP2Ls4IXNoRtndG3PkrnjUSnXAOt5CkbDB0XJ2RictNowwCz7Ro3j1MJBvVw9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506050082
X-Authority-Analysis: v=2.4 cv=Wu0rMcfv c=1 sm=1 tr=0 ts=68416250 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PLgn_JO1-Uze-8szo8IA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: O8Tvix8aRLxqS_3rt9N0SH9bwgHarJLO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA4MiBTYWx0ZWRfX4HTv6g3D2FC4 f2iMH1LIuNpugrc2EADLDwnLEEyca4Gbe8U3OJqVKWMMoBdDOcaRUE6fSG4MzgcDcy7iLYWnCRz 3j8yapm9hr3Egzm5HeqyEZY22xKGgIH/XNkKHlYthzUVsNSmRcrZqYrlTua28zEeNWwdgFvDXxO
 sQQ3TCGwFnpO88or2qe98BCYGgVRGMzM9Wa4sNx9EbG0fy59KESNRzDpPLpkkOU4yZvadDEgW3L R/tY3/GR2TD7ULF1aspyd9yUQC0J3CG1tFZQYcrUJARmv8GiJmKQqbsCrBxxXyZnj1TBBhqid/L ijUqihK7YKO5jPBIIzOxDPKjusXXZ2mFEB4ATxAYc/tkLD1RFKdcZvj9uant+uDrglquwANWpm7
 BTsnSSdzsAsoxsf+PJ2aeixI5ZiFdL3RBnL3gFlzLqrrpPt6uBmLrs0qDlKVGSsDZ9miXQ82
X-Proofpoint-ORIG-GUID: O8Tvix8aRLxqS_3rt9N0SH9bwgHarJLO

On Thu, Jun 05, 2025 at 08:56:59AM +0200, Vlastimil Babka wrote:
> On 6/4/25 16:19, Lorenzo Stoakes wrote:
> > The walk_page_range_novma() function is rather confusing - it supports two
> > modes, one used often, the other used only for debugging.
> >
> > The first mode is the common case of traversal of kernel page tables, which
> > is what nearly all callers use this for.
> >
> > Secondly it provides an unusual debugging interface that allows for the
> > traversal of page tables in a userland range of memory even for that memory
> > which is not described by a VMA.
> >
> > It is far from certain that such page tables should even exist, but perhaps
> > this is precisely why it is useful as a debugging mechanism.
> >
> > As a result, this is utilised by ptdump only. Historically, things were
> > reversed - ptdump was the only user, and other parts of the kernel evolved
> > to use the kernel page table walking here.
> >
> > Since we have some complicated and confusing locking rules for the novma
> > case, it makes sense to separate the two usages into their own functions.
> >
> > Doing this also provide self-documentation as to the intent of the caller -
> > are they doing something rather unusual or are they simply doing a standard
> > kernel page table walk?
> >
> > We therefore establish two separate functions - walk_page_range_debug() for
> > this single usage, and walk_kernel_page_table_range() for general kernel
> > page table walking.
> >
> > We additionally make walk_page_range_debug() internal to mm.
> >
> > Note that ptdump uses the precise same function for kernel walking as a
>
> IMHO it's not clear at this point what "the precise same function" means.
>
> > convenience, so we permit this but make it very explicit by having
> > walk_page_range_novma() invoke walk_kernel_page_table_range() in this case.
>
>   ^ walk_page_range_debug()

Oops will fix.

>
> Maybe this could be reworded in the sense (AFAIU) that
> walk_page_range_debug() can be used for both user space page table walking
> or kernel depending on what mm is passed, so in the case of init_mm it
> invokes walk_kernel_page_table_range() internally.

Sure.

>
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> > v2:
> > * Renamed walk_page_range_novma() to walk_page_range_debug() as per David.
> > * Moved walk_page_range_debug() definition to mm/internal.h as per Mike.
> > * Renamed walk_page_range_kernel() to walk_kernel_page_table_range() as
> >   per David.
> >
> > v1 resend:
> > * Actually cc'd lists...
> > * Fixed mistake in walk_page_range_novma() not handling kernel mappings and
> >   update commit message to referene.
> > * Added Mike's off-list Acked-by.
> > * Fixed up comments as per Mike.
> > * Add some historic flavour to the commit message as per Mike.
> > https://lore.kernel.org/all/20250603192213.182931-1-lorenzo.stoakes@oracle.com/
> >
> > v1:
> > (accidentally sent off-list due to error in scripting)
> >
> >  arch/loongarch/mm/pageattr.c |  2 +-
> >  arch/openrisc/kernel/dma.c   |  4 +-
> >  arch/riscv/mm/pageattr.c     |  8 +--
> >  include/linux/pagewalk.h     |  7 ++-
> >  mm/hugetlb_vmemmap.c         |  2 +-
> >  mm/internal.h                |  4 ++
> >  mm/pagewalk.c                | 98 ++++++++++++++++++++++++------------
> >  mm/ptdump.c                  |  3 +-
> >  8 files changed, 82 insertions(+), 46 deletions(-)
> >
> > diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> > index 99165903908a..f5e910b68229 100644
> > --- a/arch/loongarch/mm/pageattr.c
> > +++ b/arch/loongarch/mm/pageattr.c
> > @@ -118,7 +118,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask, pgp
> >  		return 0;
> >
> >  	mmap_write_lock(&init_mm);
> > -	ret = walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL, &masks);
> > +	ret = walk_kernel_page_table_range(start, end, &pageattr_ops, NULL, &masks);
> >  	mmap_write_unlock(&init_mm);
>
> You've removed init_mm from walk_page_range_novma() but I see most callers
> do the locking of init_mm immediately around it. This suggests a version
> handling that automatically? A bit complicated by the read/write
> possibilities, so maybe not worth wrapping? Just a thought, as David says ;)

Most callers write lock interestingly, but then one read lock's, so we can't
just assume and would need to pass a boolean which would kind of suck.

Also other walkers assume the caller has the lock so it's consistent to
keep it this way.

>
> >
> >  	flush_tlb_kernel_range(start, end);
> > diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> > index 3a7b5baaa450..af932a4ad306 100644
> > --- a/arch/openrisc/kernel/dma.c
> > +++ b/arch/openrisc/kernel/dma.c
> > @@ -72,7 +72,7 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
> >  	 * them and setting the cache-inhibit bit.
> >  	 */
> >  	mmap_write_lock(&init_mm);
> > -	error = walk_page_range_novma(&init_mm, va, va + size,
> > +	error = walk_kernel_page_table_range(va, va + size,
> >  			&set_nocache_walk_ops, NULL, NULL);
> >  	mmap_write_unlock(&init_mm);
> >
> > @@ -87,7 +87,7 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
> >
> >  	mmap_write_lock(&init_mm);
> >  	/* walk_page_range shouldn't be able to fail here */
> > -	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
> > +	WARN_ON(walk_kernel_page_table_range(va, va + size,
> >  			&clear_nocache_walk_ops, NULL, NULL));
> >  	mmap_write_unlock(&init_mm);
> >  }
> > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > index d815448758a1..3f76db3d2769 100644
> > --- a/arch/riscv/mm/pageattr.c
> > +++ b/arch/riscv/mm/pageattr.c
> > @@ -299,7 +299,7 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
> >  			if (ret)
> >  				goto unlock;
> >
> > -			ret = walk_page_range_novma(&init_mm, lm_start, lm_end,
> > +			ret = walk_kernel_page_table_range(lm_start, lm_end,
> >  						    &pageattr_ops, NULL, &masks);
>
> Note this and other places break the second line's arguments alignment on
> the opening bracket. Maybe it just shows it's a bit fragile style...
>
>

Yeah I know :) I know you won't believe this coming from me, but I was
trying to minimise the churn :P
