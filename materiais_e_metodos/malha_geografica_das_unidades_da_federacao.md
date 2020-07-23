# Malha geográfica das Unidades da Federação

Vamos precisar desta malha para desenhar as unidades da federação no Mapa.

## Fonte de dados oficiais: `Site GeoFTP`
<table>
<thead>
  <tr>
    <th>Endereço FTP</th>
    <th>Arquivos para Baixar</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><a href="ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/" target="_blank" rel="noopener noreferrer">ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/</a></td>
    <td>ac/ac_unidades_da_federacao.zip<br>al/al_unidades_da_federacao.zip<br>am/am_unidades_da_federacao.zip<br>ap/ap_unidades_da_federacao.zip<br>ba/ba_unidades_da_federacao.zip<br>ce/ce_unidades_da_federacao.zip<br>df/df_unidades_da_federacao.zip<br>es/es_unidades_da_federacao.zip<br>go/go_unidades_da_federacao.zip<br>ma/ma_unidades_da_federacao.zip<br>mg/mg_unidades_da_federacao.zip<br>ms/ms_unidades_da_federacao.zip<br>mt/mt_unidades_da_federacao.zip<br>pa/pa_unidades_da_federacao.zip<br>pb/pb_unidades_da_federacao.zip<br>pe/pe_unidades_da_federacao.zip<br>pi/pi_unidades_da_federacao.zip<br>pr/pr_unidades_da_federacao.zip<br>rj/rj_unidades_da_federacao.zip<br>rn/rn_unidades_da_federacao.zip<br>ro/ro_unidades_da_federacao.zip<br>rr/rr_unidades_da_federacao.zip<br>rs/rs_unidades_da_federacao.zip<br>sc/sc_unidades_da_federacao.zip<br>se/se_unidades_da_federacao.zip<br>sp/sp_unidades_da_federacao.zip<br>to/to_unidades_da_federacao.zip</td>
  </tr>
</tbody>
</table>

Fazendo uso da aplicação `curl`, conseguimos baixa-los todos de uma vez através da linha de comando. Abra um prompt de comando e digite:

```bash
curl -OOOOOOOOOOOOOOOOOOOOOOOOOOOOOO ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2010/{ac/ac_unidades_da_federacao.zip,al/al_unidades_da_federacao.zip,am/am_unidades_da_federacao.zip,ap/ap_unidades_da_federacao.zip,ba/ba_unidades_da_federacao.zip,ce/ce_unidades_da_federacao.zip,df/df_unidades_da_federacao.zip,es/es_unidades_da_federacao.zip,go/go_unidades_da_federacao.zip,ma/ma_unidades_da_federacao.zip,mg/mg_unidades_da_federacao.zip,ms/ms_unidades_da_federacao.zip,mt/mt_unidades_da_federacao.zip,pa/pa_unidades_da_federacao.zip,pb/pb_unidades_da_federacao.zip,pe/pe_unidades_da_federacao.zip,pi/pi_unidades_da_federacao.zip,pr/pr_unidades_da_federacao.zip,rj/rj_unidades_da_federacao.zip,rn/rn_unidades_da_federacao.zip,ro/ro_unidades_da_federacao.zip,rr/rr_unidades_da_federacao.zip,rs/rs_unidades_da_federacao.zip,sc/sc_unidades_da_federacao.zip,se/se_unidades_da_federacao.zip,sp/sp_unidades_da_federacao.zip,to/to_unidades_da_federacao.zip} --progress-bar

```




