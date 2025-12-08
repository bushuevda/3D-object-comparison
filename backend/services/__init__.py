from . guide_service import select_perspective, select_difference_guide, \
     select_type_image, select_type_object, select_unit_measurement, \
     insert_perspective, insert_difference_guide, insert_type_image, \
     insert_type_object, insert_unit_measurement, update_unit_measurement, \
     update_perspective, update_difference_guide, update_type_image, \
     update_type_object

from . directory_service import insert_directory, select_directory, update_directory,\
       check_files_directory, directory_add_ret_id, select_directory_obj_modeled, select_directory_obj_required,\
       select_directoris_without_compare

from . file_service import add_inf_gobj, add_inf_img, check_exist_gobj

from . perceptron_service import insert_model_nn, select_model_nn

from . analytical_service import get_images_directory, get_object_directory,\
       get_model_nn_directory, add_result_compare, add_diff_value, change_type_result_compare, add_diff_images,\
       view_diffs_by_result, view_result_compare_with_model_nn, view_imgs_real_req_path_by_result,\
       view_imgs_real_mod_req_path_by_result, view_imgs_diff_path_by_result, view_gobj_modeled_by_result, \
       view_gobj_required_by_result, view_result_compare_reports