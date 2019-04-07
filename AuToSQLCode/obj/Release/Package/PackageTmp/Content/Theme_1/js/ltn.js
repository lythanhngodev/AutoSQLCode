        //getAjax = (duongDanAjax, duLieuGui) => { var result = null; $.ajax({ type: "POST", url: duongDanAjax, data: JSON.stringify(duLieuGui), contentType: "application/json; charset=utf-8", dataType: "json", async: false, success: function (response) { result = response.d; }, error: function (response) { } }); if (result === null) return null; return JSON.parse(result.toString()); }
        //$(()=>{
        //    $('select').select2();

        //    $('#selCSDL').change(function () {
        //        try {
        //            $('.container').find('#selBang option:eq(0)').prop('selected', true).change();
        //            $('.container').find('#selBang option').not('option:eq(0)').remove();
        //            var r = getAjax('Index.aspx/LayBangTuCSDL', { csdl: $(this).val(), kn: $('#chuoiketnoi').val() });
        //            $.each(r, function () {
        //                $('#selBang').append($('<option></option>').val(this['name']).html(this['name']));
        //            });
        //        } catch (e) {
        //            return false;
        //        }
        //    });
        //    $('#selBang').change(function () {
        //        try {
        //            var r = getAjax('Index.aspx/LayCotTuBang', { csdl: [$('#selCSDL').val(), $('#selBang').val()], kn: $('#chuoiketnoi').val() });
        //            $.each(r, function () {
        //                $('#cottrongbang').append(`<li><div class='khungcheckbox'><input type='checkbox' name='${this['TenCot']} ${this['Kieu']}' checked='checked'>&ensp;${this['TenCot']} ${this['Kieu']}</div></li>`);
        //            });
        //            $('input[type=checkbox][name=chontatca]').prop('checked', true);
        //        } catch (e) {
        //            return false;
        //        }
        //    });
        //});
        //$('input[type=checkbox][name=chontatca]').click(()=>{
        //    ($('input[type=checkbox][name=chontatca]').prop('checked')) ? $('input[type=checkbox]').prop('checked', !0) : $('input[type=checkbox]').prop('checked', !1);
        //});
        //$(document).on('click', '#selCSDL,#selBang', ()=>{
        //    $('#cottrongbang').empty();
        //    $('#khungketqua').find('input,textarea').val(null);
        //});
        //ketnoi=()=>{
        //    var r = getAjax('Index.aspx/LayCSDL', { csdl: $('#chuoiketnoi').val() });
        //    $.each(r, function () {
        //        $('#selCSDL').append($('<option></option>').val(this['name']).html(this['name']));
        //    });
        //    if (jQuery.isEmptyObject(r)) {
        //        $('.container').find('select option:eq(0)').prop('selected', !0).change();
        //        $('.container').find('select option').not('option:eq(0)').remove();
        //    }
        //}
        //mau=()=>{
        //    var array = new Array(), array_update = new Array(), array_del = new Array(), array_proc_par = new Array();
        //    $('input[type=checkbox]').not('input[type=checkbox][name=chontatca]').each(function () {
        //        $(this).is(':checked') && (
        //            array.push($(this).attr('name').split(' ')[0]),
        //            array_del.push($(this).attr('name').split(' ')[0]),
        //            array_update.push($(this).attr('name').split(' ')[0] + " = @" + $(this).attr('name').split(' ')[0]),
        //            array_proc_par.push(['@' + $(this).attr('name').split(' ')[0] + ' ' + $(this).attr('name').split(' ')[1]])
        //        )
        //    });
        //    var stringjoin = array.join(", "), string_join_param = "\t\t@" + array.join(",\n\t\t@"), stringjoin_update = '\t' + array_update.join(",\n\t");
        //    var string_proc_par = array_proc_par.join(",\n");
        //    array.length = 0;
        //    array.push(stringjoin);
        //    array.push(string_join_param);
        //    array.push(stringjoin_update);
        //    (jQuery.isEmptyObject(array_del)) ? array.push(null) : array.push(array_del[0]);
        //    array.push(string_proc_par);
        //    return array;
        //}
        //Param=(obj)=>{
        //    var sql = "SqlCommand sqlCmd = new SqlCommand(strSQL, sqlConn);\n";
        //    $.each(obj, function (i, v) {
        //        sql += `sqlCmd.Parameters.AddWithValue(\"@${v}\", _arrayT[${i}].ToString());\n`;
        //    });
        //    $('#txtparam').val(sql);
        //}
        //them=()=>{
        //    try {
        //        var obj = mau();
        //        $('#ketqua').val(`INSERT INTO \n\t${$('#selBang').val()} (${obj[0]}) \nVALUES \n\t(\n${obj[1]}\n\t)`);
        //        $('#par').val(`${obj[4]}`);
        //        Param((obj[0].split(", ")));
        //    } catch (e) {

        //    }
        //}
        //sua=()=>{
        //    var obj = mau();
        //    var where = null;
        //    try {
        //        where = obj[0].split(", ")[0];
        //        $('#ketqua').val(`UPDATE ${$('#selBang').val()}\nSET\n  ${obj[2]}\nWHERE ${where} = @${where}`);
        //        Param((obj[0].split(", ")));
        //    } catch (e) {

        //    }
        //}
        //xoa=()=>{
        //    try {
        //        var obj = mau();
        //        $('#ketqua').val(`DELETE FROM ${$('#selBang').val()} WHERE ${obj[3]} = @${obj[3]}`);
        //        Param([(obj[0].split(", "))[0]]);
        //    } catch (e) {

        //    }
        //}
        //getAjax = (duongDanAjax, duLieuGui) => { var result = null; $.ajax({ type: "POST", url: duongDanAjax, data: JSON.stringify(duLieuGui), contentType: "application/json; charset=utf-8", dataType: "json", async: !1, success: function (response) { result = response.d }, error: function (response) { } }); if (result === null) return null; return JSON.parse(result.toString()) }; $(function () { $('select').select2(); $('#selCSDL').change(function () { try { $('.container').find('#selBang option:eq(0)').prop('selected', !0).change(); $('.container').find('#selBang option').not('option:eq(0)').remove(); var r = getAjax('Index.aspx/LayBangTuCSDL', { csdl: $(this).val(), kn: $('#chuoiketnoi').val() }); $.each(r, function () { $('#selBang').append($('<option></option>').val(this['name']).html(this['name'])) }) } catch (e) { return !1 } }); $('#selBang').change(function () { try { var param = new Array(); param.push($('#selCSDL').val()); param.push($('#selBang').val()); var r = getAjax('Index.aspx/LayCotTuBang', { csdl: param, kn: $('#chuoiketnoi').val() }); $.each(r, function () { $('#cottrongbang').append(`<li><div class='khungcheckbox'><input type='checkbox' name='${this['TenCot']} ${this['Kieu']}' checked='checked'>&ensp;${this['TenCot']} ${this['Kieu']}</div></li>`) }); $('input[type=checkbox][name=chontatca]').prop('checked', !0) } catch (e) { return !1 } }) }); $('input[type=checkbox][name=chontatca]').click(function () { ($('input[type=checkbox][name=chontatca]').prop('checked')) ? $('input[type=checkbox]').prop('checked', !0) : $('input[type=checkbox]').prop('checked', !1) }); $(document).on('click', '#selCSDL,#selBang', function () { $('#cottrongbang').empty(); $('#khungketqua').find('input,textarea').val(null) }); function ketnoi() { var r = getAjax('Index.aspx/LayCSDL', { csdl: $('#chuoiketnoi').val() }); $.each(r, function () { $('#selCSDL').append($('<option></option>').val(this['name']).html(this['name'])) }); if (jQuery.isEmptyObject(r)) { $('.container').find('select option:eq(0)').prop('selected', !0).change(); $('.container').find('select option').not('option:eq(0)').remove() } }; function mau() { var array = new Array(), array_update = new Array(), array_del = new Array(), array_proc_par = new Array(); $('input[type=checkbox]').not('input[type=checkbox][name=chontatca]').each(function () { $(this).is(':checked') && (array.push($(this).attr('name').split(' ')[0]), array_del.push($(this).attr('name').split(' ')[0]), array_update.push($(this).attr('name').split(' ')[0] + " = @" + $(this).attr('name').split(' ')[0]), array_proc_par.push(['@' + $(this).attr('name').split(' ')[0] + ' ' + $(this).attr('name').split(' ')[1]])) }); var stringjoin = array.join(", "), string_join_param = "\t\t@" + array.join(",\n\t\t@"), stringjoin_update = '\t' + array_update.join(",\n\t"); var string_proc_par = array_proc_par.join(",\n"); array.length = 0; array.push(stringjoin); array.push(string_join_param); array.push(stringjoin_update); (jQuery.isEmptyObject(array_del)) ? array.push(null) : array.push(array_del[0]); array.push(string_proc_par); return array }; function Param(obj) { var sql = "SqlCommand sqlCmd = new SqlCommand(strSQL, sqlConn);\n"; $.each(obj, function (i, v) { sql += `sqlCmd.Parameters.AddWithValue(\"@${v}\", _arrayT[${i}].ToString());\n` }); $('#txtparam').val(sql) }; function them() { var obj = mau(); $('#ketqua').val(`INSERT INTO \n\t${$('#selBang').val()} (${obj[0]}) \nVALUES \n\t(\n${obj[1]}\n\t)`); $('#par').val(`${obj[4]}`); Param((obj[0].split(", "))) }; function sua() { var obj = mau(); var where = null; try { where = obj[0].split(", ")[0] } catch (e) { }; $('#ketqua').val(`UPDATE ${$('#selBang').val()}\nSET\n  ${obj[2]}\nWHERE ${where} = @${where}`); Param((obj[0].split(", "))) }; function xoa() { var obj = mau(); $('#ketqua').val(`DELETE FROM ${$('#selBang').val()} WHERE ${obj[3]} = @${obj[3]}`); Param([(obj[0].split(", "))[0]]) }
