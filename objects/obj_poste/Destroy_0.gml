// feather disable GM2017
if (ds_exists(global.lista_luzes, ds_type_list)) {
    var _index = ds_list_find_index(global.lista_luzes, id);
    if (_index != -1) {
        ds_list_delete(global.lista_luzes, _index);
    }
}
