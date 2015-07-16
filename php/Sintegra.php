<?php

/**
 * @author: Marlon Vismari
 * @date: 14/07/2015
 */
require_once 'autoload.php';

final class Sintegra extends Spider {

    // Colunas JSON
    public $NomeColunas = array(
            'CNPJ',
            'IncricaoEstadual',
            'RazaoSocial',
            'Logradouro',
            'Numero',
            'Complemento',
            'Bairro',
            'Municipio',
            'UF',
            'CEP',
            'Telefone',
            'AtividadeEconomica',
            'AtividadeEconomicaDataInicio',
            'SituacaoCadastralVigente',
            'DataDestaSituacaoCadastral',
            'RegimeDeApuracao',
            'EmitenteDeNFEDesde',
            'ObrigadaAEmitirNFEEm'
        );
    
   
    
    public function buscarDados($paramCNPJ) {
        // Página em HTML
        $PaginaEmHtml = $this->request('http://www.sintegra.es.gov.br/resultado.php', 'POST', 'http://www.sintegra.es.gov.br/index.php', array('num_cnpj' => $paramCNPJ, 'num_ie' => '', 'botao' => 'Consultar'));

        // Dados de saída
        $Informacoes = array();

        $Dom = new DOMDocument();
        $Dom->loadHTML($PaginaEmHtml);
        $DomXPath = new DOMXPath($Dom);
        $Nodes = $DomXPath->query("//td[@class='valor']");
        $iColuna = 0;
        foreach ($Nodes as $node) {
            if(isset($NomeColunas[$iColuna]))
                $Informacoes[$this->NomeColunas[$iColuna++]] = $node->nodeValue;
        }
        
        return json_encode(array('dados' => $Informacoes));
        
    }
}
