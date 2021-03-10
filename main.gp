encode(m)=fromdigits(Vec(Vecsmall(m)),128);
decode(m)={
	dg=digits(m, 128);
	Strchr(vector(#dg, i, if(dg[i] == 0, 32, dg[i])));
};

\\ Le symbole de Kronecker ainsi que la parité du message d'origine permmettent de discriminer les quatre racines possibles
decipher(m, p, q) = {
	c=Mod(m[1],n);
	k=m[2];
	e=m[3];
	mp = c^((p + 1) / 4);
	mq = c^((q + 1) / 4);
	b=bezout(p, q);
	yp = b[1];
	yq = b[2];
	r1 = (yp * p * mq + yq * q * mp);
	r2 = n - r1;
	r3 = (yp * p * mq - yq * q * mp);
	r4 = n - r3;
	print(decode(lift(r4)));
};

PollardRho(n) = {
	i = 2; a = 2;
	while(1, a=(a^i) % n; d=gcd(a-1, n); if(d > 1, break); i+=1);
	d;
};

[n,c] = readvec("input.txt");

\\ on détermine un facteur de n via la méthode Rho de Pollard
\\ (p-1 and q-1 sont friables avec comme plus grand facteur premier 1723...)
p=PollardRho(n);

q=n/p;
decipher(c, p, q);
