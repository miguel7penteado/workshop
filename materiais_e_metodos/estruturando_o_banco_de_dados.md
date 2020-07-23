# Estruturando o Banco de Dados

O Banco de Dados guardado no SGBD Postgres vai trabalhar com um montante de mais de 100 GB de dados consolidados. Este volume de informação deve estar bem organzado e indexado para que não inviabilize o tempo das consultas relacionais ou espaciais, de modo que neste projeto, iremos **orgazinar os datasets em esquemas** e **particiona-los, quando possível**, também utilizando esquemas contendo apenas dados de cada uma das 27 Unidades da Federação.

O banco de dados divido em esquemas ficará com o aspecto da tabela a seguir:

<table>
<thead>
  <tr>
    <th>Numero</th>
    <th>Nome do esquema</th>
    <th>Dataset</th>
    <th>Filtragem</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td>1</td>
    <td>microdados.agregados.setor.censo2010</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>2</td>
    <td>microdados.agregados.setor.censo2010.ac</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ac</td>
  </tr>
  <tr>
    <td>3</td>
    <td>microdados.agregados.setor.censo2010.al</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>al</td>
  </tr>
  <tr>
    <td>4</td>
    <td>microdados.agregados.setor.censo2010.ap</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ap</td>
  </tr>
  <tr>
    <td>5</td>
    <td>microdados.agregados.setor.censo2010.am</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>am</td>
  </tr>
  <tr>
    <td>6</td>
    <td>microdados.agregados.setor.censo2010.ba</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ba</td>
  </tr>
  <tr>
    <td>7</td>
    <td>microdados.agregados.setor.censo2010.ce</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ce</td>
  </tr>
  <tr>
    <td>8</td>
    <td>microdados.agregados.setor.censo2010.df</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>df</td>
  </tr>
  <tr>
    <td>9</td>
    <td>microdados.agregados.setor.censo2010.es</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>es</td>
  </tr>
  <tr>
    <td>10</td>
    <td>microdados.agregados.setor.censo2010.go</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>go</td>
  </tr>
  <tr>
    <td>11</td>
    <td>microdados.agregados.setor.censo2010.ma</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ma</td>
  </tr>
  <tr>
    <td>12</td>
    <td>microdados.agregados.setor.censo2010.mt</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mt</td>
  </tr>
  <tr>
    <td>13</td>
    <td>microdados.agregados.setor.censo2010.ms</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ms</td>
  </tr>
  <tr>
    <td>14</td>
    <td>microdados.agregados.setor.censo2010.mg</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mg</td>
  </tr>
  <tr>
    <td>15</td>
    <td>microdados.agregados.setor.censo2010.pa</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pa</td>
  </tr>
  <tr>
    <td>16</td>
    <td>microdados.agregados.setor.censo2010.pb</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pb</td>
  </tr>
  <tr>
    <td>17</td>
    <td>microdados.agregados.setor.censo2010.pe</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pe</td>
  </tr>
  <tr>
    <td>18</td>
    <td>microdados.agregados.setor.censo2010.pi</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pi</td>
  </tr>
  <tr>
    <td>19</td>
    <td>microdados.agregados.setor.censo2010.pr</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pr</td>
  </tr>
  <tr>
    <td>20</td>
    <td>microdados.agregados.setor.censo2010.rj</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rj</td>
  </tr>
  <tr>
    <td>21</td>
    <td>microdados.agregados.setor.censo2010.rn</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rn</td>
  </tr>
  <tr>
    <td>22</td>
    <td>microdados.agregados.setor.censo2010.rs</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rs</td>
  </tr>
  <tr>
    <td>23</td>
    <td>microdados.agregados.setor.censo2010.ro</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ro</td>
  </tr>
  <tr>
    <td>24</td>
    <td>microdados.agregados.setor.censo2010.rr</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rr</td>
  </tr>
  <tr>
    <td>25</td>
    <td>microdados.agregados.setor.censo2010.sc</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sc</td>
  </tr>
  <tr>
    <td>26</td>
    <td>microdados.agregados.setor.censo2010.sp</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sp</td>
  </tr>
  <tr>
    <td>27</td>
    <td>microdados.agregados.setor.censo2010.se</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>se</td>
  </tr>
  <tr>
    <td>28</td>
    <td>microdados.agregados.setor.censo2010.to</td>
    <td>Agregagos_por_setor + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>to</td>
  </tr>
  <tr>
    <td>29</td>
    <td>microdados.amostra.domicilios.censo2010</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>30</td>
    <td>microdados.amostra.domicilios.censo2010.ac</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ac</td>
  </tr>
  <tr>
    <td>31</td>
    <td>microdados.amostra.domicilios.censo2010.al</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>al</td>
  </tr>
  <tr>
    <td>32</td>
    <td>microdados.amostra.domicilios.censo2010.ap</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ap</td>
  </tr>
  <tr>
    <td>33</td>
    <td>microdados.amostra.domicilios.censo2010.am</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>am</td>
  </tr>
  <tr>
    <td>34</td>
    <td>microdados.amostra.domicilios.censo2010.ba</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ba</td>
  </tr>
  <tr>
    <td>35</td>
    <td>microdados.amostra.domicilios.censo2010.ce</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ce</td>
  </tr>
  <tr>
    <td>36</td>
    <td>microdados.amostra.domicilios.censo2010.df</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>df</td>
  </tr>
  <tr>
    <td>37</td>
    <td>microdados.amostra.domicilios.censo2010.es</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>es</td>
  </tr>
  <tr>
    <td>38</td>
    <td>microdados.amostra.domicilios.censo2010.go</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>go</td>
  </tr>
  <tr>
    <td>39</td>
    <td>microdados.amostra.domicilios.censo2010.ma</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ma</td>
  </tr>
  <tr>
    <td>40</td>
    <td>microdados.amostra.domicilios.censo2010.mt</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mt</td>
  </tr>
  <tr>
    <td>41</td>
    <td>microdados.amostra.domicilios.censo2010.ms</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ms</td>
  </tr>
  <tr>
    <td>42</td>
    <td>microdados.amostra.domicilios.censo2010.mg</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mg</td>
  </tr>
  <tr>
    <td>43</td>
    <td>microdados.amostra.domicilios.censo2010.pa</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pa</td>
  </tr>
  <tr>
    <td>44</td>
    <td>microdados.amostra.domicilios.censo2010.pb</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pb</td>
  </tr>
  <tr>
    <td>45</td>
    <td>microdados.amostra.domicilios.censo2010.pe</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pe</td>
  </tr>
  <tr>
    <td>46</td>
    <td>microdados.amostra.domicilios.censo2010.pi</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pi</td>
  </tr>
  <tr>
    <td>47</td>
    <td>microdados.amostra.domicilios.censo2010.pr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pr</td>
  </tr>
  <tr>
    <td>48</td>
    <td>microdados.amostra.domicilios.censo2010.rj</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rj</td>
  </tr>
  <tr>
    <td>49</td>
    <td>microdados.amostra.domicilios.censo2010.rn</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rn</td>
  </tr>
  <tr>
    <td>50</td>
    <td>microdados.amostra.domicilios.censo2010.rs</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rs</td>
  </tr>
  <tr>
    <td>51</td>
    <td>microdados.amostra.domicilios.censo2010.ro</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ro</td>
  </tr>
  <tr>
    <td>52</td>
    <td>microdados.amostra.domicilios.censo2010.rr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rr</td>
  </tr>
  <tr>
    <td>53</td>
    <td>microdados.amostra.domicilios.censo2010.sc</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sc</td>
  </tr>
  <tr>
    <td>54</td>
    <td>microdados.amostra.domicilios.censo2010.sp</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sp</td>
  </tr>
  <tr>
    <td>55</td>
    <td>microdados.amostra.domicilios.censo2010.se</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>se</td>
  </tr>
  <tr>
    <td>56</td>
    <td>microdados.amostra.domicilios.censo2010.to</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>to</td>
  </tr>
  <tr>
    <td>57</td>
    <td>microdados.amostra.emigracao-internacional.censo2010</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>58</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ac</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ac</td>
  </tr>
  <tr>
    <td>59</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.al</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>al</td>
  </tr>
  <tr>
    <td>60</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ap</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ap</td>
  </tr>
  <tr>
    <td>61</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.am</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>am</td>
  </tr>
  <tr>
    <td>62</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ba</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ba</td>
  </tr>
  <tr>
    <td>63</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ce</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ce</td>
  </tr>
  <tr>
    <td>64</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.df</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>df</td>
  </tr>
  <tr>
    <td>65</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.es</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>es</td>
  </tr>
  <tr>
    <td>66</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.go</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>go</td>
  </tr>
  <tr>
    <td>67</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ma</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ma</td>
  </tr>
  <tr>
    <td>68</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.mt</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mt</td>
  </tr>
  <tr>
    <td>69</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ms</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ms</td>
  </tr>
  <tr>
    <td>70</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.mg</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mg</td>
  </tr>
  <tr>
    <td>71</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.pa</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pa</td>
  </tr>
  <tr>
    <td>72</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.pb</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pb</td>
  </tr>
  <tr>
    <td>73</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.pe</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pe</td>
  </tr>
  <tr>
    <td>74</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.pi</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pi</td>
  </tr>
  <tr>
    <td>75</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.pr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pr</td>
  </tr>
  <tr>
    <td>76</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.rj</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rj</td>
  </tr>
  <tr>
    <td>77</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.rn</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rn</td>
  </tr>
  <tr>
    <td>78</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.rs</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rs</td>
  </tr>
  <tr>
    <td>79</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.ro</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ro</td>
  </tr>
  <tr>
    <td>80</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.rr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rr</td>
  </tr>
  <tr>
    <td>81</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.sc</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sc</td>
  </tr>
  <tr>
    <td>82</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.sp</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sp</td>
  </tr>
  <tr>
    <td>83</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.se</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>se</td>
  </tr>
  <tr>
    <td>84</td>
    <td>microdados.amostra.emigracao-internacional.censo2010.to</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>to</td>
  </tr>
  <tr>
    <td>85</td>
    <td>microdados.amostra.mortalidade.censo2010</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>86</td>
    <td>microdados.amostra.mortalidade.censo2010.ac</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ac</td>
  </tr>
  <tr>
    <td>87</td>
    <td>microdados.amostra.mortalidade.censo2010.al</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>al</td>
  </tr>
  <tr>
    <td>88</td>
    <td>microdados.amostra.mortalidade.censo2010.ap</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ap</td>
  </tr>
  <tr>
    <td>89</td>
    <td>microdados.amostra.mortalidade.censo2010.am</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>am</td>
  </tr>
  <tr>
    <td>90</td>
    <td>microdados.amostra.mortalidade.censo2010.ba</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ba</td>
  </tr>
  <tr>
    <td>91</td>
    <td>microdados.amostra.mortalidade.censo2010.ce</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ce</td>
  </tr>
  <tr>
    <td>92</td>
    <td>microdados.amostra.mortalidade.censo2010.df</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>df</td>
  </tr>
  <tr>
    <td>93</td>
    <td>microdados.amostra.mortalidade.censo2010.es</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>es</td>
  </tr>
  <tr>
    <td>94</td>
    <td>microdados.amostra.mortalidade.censo2010.go</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>go</td>
  </tr>
  <tr>
    <td>95</td>
    <td>microdados.amostra.mortalidade.censo2010.ma</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ma</td>
  </tr>
  <tr>
    <td>96</td>
    <td>microdados.amostra.mortalidade.censo2010.mt</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mt</td>
  </tr>
  <tr>
    <td>97</td>
    <td>microdados.amostra.mortalidade.censo2010.ms</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ms</td>
  </tr>
  <tr>
    <td>98</td>
    <td>microdados.amostra.mortalidade.censo2010.mg</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mg</td>
  </tr>
  <tr>
    <td>99</td>
    <td>microdados.amostra.mortalidade.censo2010.pa</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pa</td>
  </tr>
  <tr>
    <td>100</td>
    <td>microdados.amostra.mortalidade.censo2010.pb</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pb</td>
  </tr>
  <tr>
    <td>101</td>
    <td>microdados.amostra.mortalidade.censo2010.pe</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pe</td>
  </tr>
  <tr>
    <td>102</td>
    <td>microdados.amostra.mortalidade.censo2010.pi</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pi</td>
  </tr>
  <tr>
    <td>103</td>
    <td>microdados.amostra.mortalidade.censo2010.pr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pr</td>
  </tr>
  <tr>
    <td>104</td>
    <td>microdados.amostra.mortalidade.censo2010.rj</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rj</td>
  </tr>
  <tr>
    <td>105</td>
    <td>microdados.amostra.mortalidade.censo2010.rn</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rn</td>
  </tr>
  <tr>
    <td>106</td>
    <td>microdados.amostra.mortalidade.censo2010.rs</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rs</td>
  </tr>
  <tr>
    <td>107</td>
    <td>microdados.amostra.mortalidade.censo2010.ro</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ro</td>
  </tr>
  <tr>
    <td>108</td>
    <td>microdados.amostra.mortalidade.censo2010.rr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rr</td>
  </tr>
  <tr>
    <td>109</td>
    <td>microdados.amostra.mortalidade.censo2010.sc</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sc</td>
  </tr>
  <tr>
    <td>110</td>
    <td>microdados.amostra.mortalidade.censo2010.sp</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sp</td>
  </tr>
  <tr>
    <td>111</td>
    <td>microdados.amostra.mortalidade.censo2010.se</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>se</td>
  </tr>
  <tr>
    <td>112</td>
    <td>microdados.amostra.mortalidade.censo2010.to</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>to</td>
  </tr>
  <tr>
    <td>113</td>
    <td>microdados.amostra.pessoas.censo2010</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>114</td>
    <td>microdados.amostra.pessoas.censo2010.ac</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ac</td>
  </tr>
  <tr>
    <td>115</td>
    <td>microdados.amostra.pessoas.censo2010.al</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>al</td>
  </tr>
  <tr>
    <td>116</td>
    <td>microdados.amostra.pessoas.censo2010.ap</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ap</td>
  </tr>
  <tr>
    <td>117</td>
    <td>microdados.amostra.pessoas.censo2010.am</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>am</td>
  </tr>
  <tr>
    <td>118</td>
    <td>microdados.amostra.pessoas.censo2010.ba</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ba</td>
  </tr>
  <tr>
    <td>119</td>
    <td>microdados.amostra.pessoas.censo2010.ce</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ce</td>
  </tr>
  <tr>
    <td>120</td>
    <td>microdados.amostra.pessoas.censo2010.df</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>df</td>
  </tr>
  <tr>
    <td>121</td>
    <td>microdados.amostra.pessoas.censo2010.es</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>es</td>
  </tr>
  <tr>
    <td>122</td>
    <td>microdados.amostra.pessoas.censo2010.go</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>go</td>
  </tr>
  <tr>
    <td>123</td>
    <td>microdados.amostra.pessoas.censo2010.ma</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ma</td>
  </tr>
  <tr>
    <td>124</td>
    <td>microdados.amostra.pessoas.censo2010.mt</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mt</td>
  </tr>
  <tr>
    <td>125</td>
    <td>microdados.amostra.pessoas.censo2010.ms</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ms</td>
  </tr>
  <tr>
    <td>126</td>
    <td>microdados.amostra.pessoas.censo2010.mg</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>mg</td>
  </tr>
  <tr>
    <td>127</td>
    <td>microdados.amostra.pessoas.censo2010.pa</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pa</td>
  </tr>
  <tr>
    <td>128</td>
    <td>microdados.amostra.pessoas.censo2010.pb</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pb</td>
  </tr>
  <tr>
    <td>129</td>
    <td>microdados.amostra.pessoas.censo2010.pe</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pe</td>
  </tr>
  <tr>
    <td>130</td>
    <td>microdados.amostra.pessoas.censo2010.pi</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pi</td>
  </tr>
  <tr>
    <td>131</td>
    <td>microdados.amostra.pessoas.censo2010.pr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>pr</td>
  </tr>
  <tr>
    <td>132</td>
    <td>microdados.amostra.pessoas.censo2010.rj</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rj</td>
  </tr>
  <tr>
    <td>133</td>
    <td>microdados.amostra.pessoas.censo2010.rn</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rn</td>
  </tr>
  <tr>
    <td>134</td>
    <td>microdados.amostra.pessoas.censo2010.rs</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rs</td>
  </tr>
  <tr>
    <td>135</td>
    <td>microdados.amostra.pessoas.censo2010.ro</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>ro</td>
  </tr>
  <tr>
    <td>136</td>
    <td>microdados.amostra.pessoas.censo2010.rr</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>rr</td>
  </tr>
  <tr>
    <td>137</td>
    <td>microdados.amostra.pessoas.censo2010.sc</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sc</td>
  </tr>
  <tr>
    <td>138</td>
    <td>microdados.amostra.pessoas.censo2010.sp</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>sp</td>
  </tr>
  <tr>
    <td>139</td>
    <td>microdados.amostra.pessoas.censo2010.se</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>se</td>
  </tr>
  <tr>
    <td>140</td>
    <td>microdados.amostra.pessoas.censo2010.to</td>
    <td>Microdados_da_Amostra + malhas estaduais, municipais, distritais, subdistritais, setoriais, quadra-face, CENEFE</td>
    <td>to</td>
  </tr>
  <tr>
    <td>141</td>
    <td>mma.cnuc</td>
    <td>CNUC</td>
    <td>Brasil</td>
  </tr>
  <tr>
    <td>142</td>
    <td>microdados.ibge.cnefe.censo2010</td>
    <td>CNEFE</td>
    <td>Brasil</td>
  </tr>
</tbody>
</table>

