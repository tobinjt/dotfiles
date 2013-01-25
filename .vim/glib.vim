" Vim syntax file
" Language: C glib extension (for version 2.4.2)
" Maintainer: David Nečas (Yeti) <yeti@physics.muni.cz>
" Last Change: 2004-06-11
" URL: http://trific.ath.cx/Ftp/vim/syntax/gtk-syntax.tar.gz
" Generated By: vim-syn-gen.py
" Options: let glib_enable_deprecated = 1
"          enables highlighting of deprecated declarations (if any).

syn keyword glibFunction alloca g_allocator_free g_allocator_new g_array_append_vals g_array_free g_array_insert_vals g_array_new g_array_prepend_vals g_array_remove_index g_array_remove_index_fast g_array_remove_range g_array_set_size g_array_sized_new g_array_sort g_array_sort_with_data g_ascii_digit_value g_ascii_dtostr g_ascii_formatd g_ascii_strcasecmp g_ascii_strdown g_ascii_strncasecmp g_ascii_strtod g_ascii_strtoull g_ascii_strup g_ascii_tolower g_ascii_toupper g_ascii_xdigit_value g_async_queue_length g_async_queue_length_unlocked g_async_queue_lock g_async_queue_new g_async_queue_pop g_async_queue_pop_unlocked g_async_queue_push g_async_queue_push_unlocked g_async_queue_ref g_async_queue_timed_pop g_async_queue_timed_pop_unlocked g_async_queue_try_pop g_async_queue_try_pop_unlocked g_async_queue_unlock g_async_queue_unref g_atexit g_atomic_int_add g_atomic_int_compare_and_exchange g_atomic_int_exchange_and_add g_atomic_int_get g_atomic_pointer_compare_and_exchange g_atomic_pointer_get g_bit_nth_lsf g_bit_nth_msf g_bit_storage g_blow_chunks g_build_filename g_build_path g_byte_array_append g_byte_array_free g_byte_array_new g_byte_array_prepend g_byte_array_remove_index g_byte_array_remove_index_fast g_byte_array_remove_range g_byte_array_set_size g_byte_array_sized_new g_byte_array_sort g_byte_array_sort_with_data g_cache_destroy g_cache_insert g_cache_key_foreach g_cache_new g_cache_remove g_cache_value_foreach g_child_watch_add g_child_watch_add_full g_child_watch_source_new g_clear_error g_completion_add_items g_completion_clear_items g_completion_complete g_completion_complete_utf8 g_completion_free g_completion_new g_completion_remove_items g_completion_set_compare g_convert g_convert_error_quark g_convert_with_fallback g_convert_with_iconv g_datalist_clear g_datalist_foreach g_datalist_id_get_data g_datalist_id_remove_no_notify g_datalist_id_set_data_full g_datalist_init g_dataset_destroy g_dataset_foreach g_dataset_id_get_data g_dataset_id_remove_no_notify g_dataset_id_set_data_full g_date_add_days g_date_add_months g_date_add_years g_date_clamp g_date_clear g_date_compare g_date_days_between g_date_free g_date_get_day g_date_get_day_of_year g_date_get_days_in_month g_date_get_julian g_date_get_monday_week_of_year g_date_get_monday_weeks_in_year g_date_get_month g_date_get_sunday_week_of_year g_date_get_sunday_weeks_in_year g_date_get_weekday g_date_get_year g_date_is_first_of_month g_date_is_last_of_month g_date_is_leap_year g_date_new g_date_new_dmy g_date_new_julian g_date_order g_date_set_day g_date_set_dmy g_date_set_julian g_date_set_month g_date_set_parse g_date_set_time g_date_set_year g_date_strftime g_date_subtract_days g_date_subtract_months g_date_subtract_years g_date_to_struct_tm g_date_valid g_date_valid_day g_date_valid_dmy g_date_valid_julian g_date_valid_month g_date_valid_weekday g_date_valid_year g_dir_close g_dir_open g_dir_read_name g_dir_rewind g_direct_equal g_direct_hash g_error_copy g_error_free g_error_matches g_error_new g_error_new_literal g_file_error_from_errno g_file_error_quark g_file_get_contents g_file_open_tmp g_file_read_link g_file_test g_filename_from_uri g_filename_from_utf8 g_filename_to_uri g_filename_to_utf8 g_find_program_in_path g_fprintf g_free g_get_application_name g_get_charset g_get_current_dir g_get_current_time g_get_home_dir g_get_prgname g_get_real_name g_get_tmp_dir g_get_user_name g_getenv g_hash_table_destroy g_hash_table_find g_hash_table_foreach g_hash_table_foreach_remove g_hash_table_foreach_steal g_hash_table_insert g_hash_table_lookup g_hash_table_lookup_extended g_hash_table_new g_hash_table_new_full g_hash_table_remove g_hash_table_replace g_hash_table_size g_hash_table_steal g_hook_alloc g_hook_compare_ids g_hook_destroy g_hook_destroy_link g_hook_find g_hook_find_data g_hook_find_func g_hook_find_func_data g_hook_first_valid g_hook_free g_hook_get g_hook_insert_before g_hook_insert_sorted g_hook_list_clear g_hook_list_init g_hook_list_invoke g_hook_list_invoke_check g_hook_list_marshal g_hook_list_marshal_check g_hook_next_valid g_hook_prepend g_hook_ref g_hook_unref g_iconv g_iconv_close g_iconv_open g_idle_add g_idle_add_full g_idle_remove_by_data g_idle_source_new g_int_equal g_int_hash g_io_add_watch g_io_add_watch_full g_io_channel_error_from_errno g_io_channel_error_quark g_io_channel_flush g_io_channel_get_buffer_condition g_io_channel_get_buffer_size g_io_channel_get_buffered g_io_channel_get_close_on_unref g_io_channel_get_encoding g_io_channel_get_flags g_io_channel_get_line_term g_io_channel_init g_io_channel_new_file g_io_channel_read_chars g_io_channel_read_line g_io_channel_read_line_string g_io_channel_read_to_end g_io_channel_read_unichar g_io_channel_ref g_io_channel_seek_position g_io_channel_set_buffer_size g_io_channel_set_buffered g_io_channel_set_close_on_unref g_io_channel_set_encoding g_io_channel_set_flags g_io_channel_set_line_term g_io_channel_shutdown g_io_channel_unix_get_fd g_io_channel_unix_new g_io_channel_unref g_io_channel_win32_get_fd g_io_channel_win32_make_pollfd g_io_channel_win32_new_fd g_io_channel_win32_new_messages g_io_channel_win32_new_socket g_io_channel_win32_poll g_io_channel_write_chars g_io_channel_write_unichar g_io_create_watch g_list_alloc g_list_append g_list_concat g_list_copy g_list_delete_link g_list_find g_list_find_custom g_list_first g_list_foreach g_list_free g_list_free_1 g_list_index g_list_insert g_list_insert_before g_list_insert_sorted g_list_last g_list_length g_list_nth g_list_nth_data g_list_nth_prev g_list_pop_allocator g_list_position g_list_prepend g_list_push_allocator g_list_remove g_list_remove_all g_list_remove_link g_list_reverse g_list_sort g_list_sort_with_data g_locale_from_utf8 g_locale_to_utf8 g_log g_log_default_handler g_log_remove_handler g_log_set_always_fatal g_log_set_fatal_mask g_log_set_handler g_logv g_main_context_acquire g_main_context_add_poll g_main_context_check g_main_context_default g_main_context_dispatch g_main_context_find_source_by_funcs_user_data g_main_context_find_source_by_id g_main_context_find_source_by_user_data g_main_context_get_poll_func g_main_context_iteration g_main_context_new g_main_context_pending g_main_context_prepare g_main_context_query g_main_context_ref g_main_context_release g_main_context_remove_poll g_main_context_set_poll_func g_main_context_unref g_main_context_wait g_main_context_wakeup g_main_depth g_main_loop_get_context g_main_loop_is_running g_main_loop_new g_main_loop_quit g_main_loop_ref g_main_loop_run g_main_loop_unref g_malloc g_malloc0 g_markup_error_quark g_markup_escape_text g_markup_parse_context_end_parse g_markup_parse_context_free g_markup_parse_context_get_element g_markup_parse_context_get_position g_markup_parse_context_new g_markup_parse_context_parse g_markup_printf_escaped g_markup_vprintf_escaped g_mem_chunk_alloc g_mem_chunk_alloc0 g_mem_chunk_clean g_mem_chunk_destroy g_mem_chunk_free g_mem_chunk_info g_mem_chunk_new g_mem_chunk_print g_mem_chunk_reset g_mem_is_system_malloc g_mem_profile g_mem_set_vtable g_memdup g_mkstemp g_module_build_path g_module_close g_module_error g_module_make_resident g_module_name g_module_open g_module_supported g_module_symbol g_node_child_index g_node_child_position g_node_children_foreach g_node_copy g_node_copy_deep g_node_depth g_node_destroy g_node_find g_node_find_child g_node_first_sibling g_node_get_root g_node_insert g_node_insert_after g_node_insert_before g_node_is_ancestor g_node_last_child g_node_last_sibling g_node_max_height g_node_n_children g_node_n_nodes g_node_new g_node_nth_child g_node_pop_allocator g_node_prepend g_node_push_allocator g_node_reverse_children g_node_traverse g_node_unlink g_nullify_pointer g_on_error_query g_on_error_stack_trace g_once_impl g_parse_debug_string g_path_get_basename g_path_get_dirname g_path_is_absolute g_path_skip_root g_pattern_match g_pattern_match_simple g_pattern_match_string g_pattern_spec_equal g_pattern_spec_free g_pattern_spec_new g_print g_printerr g_printf g_printf_string_upper_bound g_propagate_error g_ptr_array_add g_ptr_array_foreach g_ptr_array_free g_ptr_array_new g_ptr_array_remove g_ptr_array_remove_fast g_ptr_array_remove_index g_ptr_array_remove_index_fast g_ptr_array_remove_range g_ptr_array_set_size g_ptr_array_sized_new g_ptr_array_sort g_ptr_array_sort_with_data g_qsort_with_data g_quark_from_static_string g_quark_from_string g_quark_to_string g_quark_try_string g_queue_copy g_queue_delete_link g_queue_find g_queue_find_custom g_queue_foreach g_queue_free g_queue_get_length g_queue_index g_queue_insert_after g_queue_insert_before g_queue_insert_sorted g_queue_is_empty g_queue_link_index g_queue_new g_queue_peek_head g_queue_peek_head_link g_queue_peek_nth g_queue_peek_nth_link g_queue_peek_tail g_queue_peek_tail_link g_queue_pop_head g_queue_pop_head_link g_queue_pop_nth g_queue_pop_nth_link g_queue_pop_tail g_queue_pop_tail_link g_queue_push_head g_queue_push_head_link g_queue_push_nth g_queue_push_nth_link g_queue_push_tail g_queue_push_tail_link g_queue_remove g_queue_remove_all g_queue_reverse g_queue_sort g_queue_unlink g_rand_copy g_rand_double g_rand_double_range g_rand_free g_rand_int g_rand_int_range g_rand_new g_rand_new_with_seed g_rand_new_with_seed_array g_rand_set_seed g_rand_set_seed_array g_random_double g_random_double_range g_random_int g_random_int_range g_random_set_seed g_realloc g_relation_count g_relation_delete g_relation_destroy g_relation_exists g_relation_index g_relation_insert g_relation_new g_relation_print g_relation_select g_scanner_cur_line g_scanner_cur_position g_scanner_cur_token g_scanner_cur_value g_scanner_destroy g_scanner_eof g_scanner_error g_scanner_get_next_token g_scanner_input_file g_scanner_input_text g_scanner_lookup_symbol g_scanner_new g_scanner_peek_next_token g_scanner_scope_add_symbol g_scanner_scope_foreach_symbol g_scanner_scope_lookup_symbol g_scanner_scope_remove_symbol g_scanner_set_scope g_scanner_sync_file_offset g_scanner_unexp_token g_scanner_warn g_set_application_name g_set_error g_set_prgname g_set_print_handler g_set_printerr_handler g_setenv g_shell_error_quark g_shell_parse_argv g_shell_quote g_shell_unquote g_slist_alloc g_slist_append g_slist_concat g_slist_copy g_slist_delete_link g_slist_find g_slist_find_custom g_slist_foreach g_slist_free g_slist_free_1 g_slist_index g_slist_insert g_slist_insert_before g_slist_insert_sorted g_slist_last g_slist_length g_slist_nth g_slist_nth_data g_slist_pop_allocator g_slist_position g_slist_prepend g_slist_push_allocator g_slist_remove g_slist_remove_all g_slist_remove_link g_slist_reverse g_slist_sort g_slist_sort_with_data g_snprintf g_source_add_poll g_source_attach g_source_destroy g_source_get_can_recurse g_source_get_context g_source_get_current_time g_source_get_id g_source_get_priority g_source_new g_source_ref g_source_remove g_source_remove_by_funcs_user_data g_source_remove_by_user_data g_source_remove_poll g_source_set_callback g_source_set_callback_indirect g_source_set_can_recurse g_source_set_priority g_source_unref g_spaced_primes_closest g_spawn_async g_spawn_async_with_pipes g_spawn_close_pid g_spawn_command_line_async g_spawn_command_line_sync g_spawn_error_quark g_spawn_sync g_sprintf g_static_mutex_free g_static_mutex_get_mutex_impl g_static_mutex_init g_static_private_free g_static_private_get g_static_private_init g_static_private_set g_static_rec_mutex_free g_static_rec_mutex_init g_static_rec_mutex_lock g_static_rec_mutex_lock_full g_static_rec_mutex_trylock g_static_rec_mutex_unlock g_static_rec_mutex_unlock_full g_static_rw_lock_free g_static_rw_lock_init g_static_rw_lock_reader_lock g_static_rw_lock_reader_trylock g_static_rw_lock_reader_unlock g_static_rw_lock_writer_lock g_static_rw_lock_writer_trylock g_static_rw_lock_writer_unlock g_stpcpy g_str_equal g_str_has_prefix g_str_has_suffix g_str_hash g_strcanon g_strchomp g_strchug g_strcompress g_strconcat g_strdelimit g_strdup g_strdup_printf g_strdup_vprintf g_strdupv g_strerror g_strescape g_strfreev g_string_append g_string_append_c g_string_append_len g_string_append_printf g_string_append_unichar g_string_ascii_down g_string_ascii_up g_string_assign g_string_chunk_free g_string_chunk_insert g_string_chunk_insert_const g_string_chunk_insert_len g_string_chunk_new g_string_equal g_string_erase g_string_free g_string_hash g_string_insert g_string_insert_c g_string_insert_len g_string_insert_unichar g_string_new g_string_new_len g_string_prepend g_string_prepend_c g_string_prepend_len g_string_prepend_unichar g_string_printf g_string_set_size g_string_sized_new g_string_truncate g_strip_context g_strjoin g_strjoinv g_strlcat g_strlcpy g_strndup g_strnfill g_strreverse g_strrstr g_strrstr_len g_strsignal g_strsplit g_strsplit_set g_strstr_len g_strtod g_thread_create_full g_thread_error_quark g_thread_exit g_thread_init g_thread_init_glib g_thread_init_with_errorcheck_mutexes g_thread_join g_thread_pool_free g_thread_pool_get_max_threads g_thread_pool_get_max_unused_threads g_thread_pool_get_num_threads g_thread_pool_get_num_unused_threads g_thread_pool_new g_thread_pool_push g_thread_pool_set_max_threads g_thread_pool_set_max_unused_threads g_thread_pool_stop_unused_threads g_thread_pool_unprocessed g_thread_self g_thread_set_priority g_time_val_add g_timeout_add g_timeout_add_full g_timeout_source_new g_timer_continue g_timer_destroy g_timer_elapsed g_timer_new g_timer_reset g_timer_start g_timer_stop g_trash_stack_height g_trash_stack_peek g_trash_stack_pop g_trash_stack_push g_tree_destroy g_tree_foreach g_tree_height g_tree_insert g_tree_lookup g_tree_lookup_extended g_tree_new g_tree_new_full g_tree_new_with_data g_tree_nnodes g_tree_remove g_tree_replace g_tree_search g_tree_steal g_try_malloc g_try_realloc g_tuples_destroy g_tuples_index g_ucs4_to_utf16 g_ucs4_to_utf8 g_unichar_break_type g_unichar_digit_value g_unichar_get_mirror_char g_unichar_isalnum g_unichar_isalpha g_unichar_iscntrl g_unichar_isdefined g_unichar_isdigit g_unichar_isgraph g_unichar_islower g_unichar_isprint g_unichar_ispunct g_unichar_isspace g_unichar_istitle g_unichar_isupper g_unichar_iswide g_unichar_isxdigit g_unichar_to_utf8 g_unichar_tolower g_unichar_totitle g_unichar_toupper g_unichar_type g_unichar_validate g_unichar_xdigit_value g_unicode_canonical_decomposition g_unicode_canonical_ordering g_unsetenv g_usleep g_utf16_to_ucs4 g_utf16_to_utf8 g_utf8_casefold g_utf8_collate g_utf8_collate_key g_utf8_find_next_char g_utf8_find_prev_char g_utf8_get_char g_utf8_get_char_validated g_utf8_normalize g_utf8_offset_to_pointer g_utf8_pointer_to_offset g_utf8_prev_char g_utf8_strchr g_utf8_strdown g_utf8_strlen g_utf8_strncpy g_utf8_strrchr g_utf8_strreverse g_utf8_strup g_utf8_to_ucs4 g_utf8_to_ucs4_fast g_utf8_to_utf16 g_utf8_validate g_vasprintf g_vfprintf g_vprintf g_vsnprintf g_vsprintf g_win32_error_message g_win32_ftruncate g_win32_get_package_installation_directory g_win32_get_package_installation_subdirectory g_win32_getlocale glib_dummy_decl
syn keyword glibTypedef GDateDay GDateYear GPid GQuark GTime gboolean gchar gconstpointer gdouble gfloat gint gint16 gint32 gint64 gint8 glong gpointer gshort gsize gssize guchar guint guint16 guint32 guint64 guint8 gulong gunichar gunichar2 gushort pid_t
syn keyword glibConstant G_ASCII_ALNUM G_ASCII_ALPHA G_ASCII_CNTRL G_ASCII_DIGIT G_ASCII_GRAPH G_ASCII_LOWER G_ASCII_PRINT G_ASCII_PUNCT G_ASCII_SPACE G_ASCII_UPPER G_ASCII_XDIGIT G_CONVERT_ERROR_BAD_URI G_CONVERT_ERROR_FAILED G_CONVERT_ERROR_ILLEGAL_SEQUENCE G_CONVERT_ERROR_NO_CONVERSION G_CONVERT_ERROR_PARTIAL_INPUT G_DATE_APRIL G_DATE_AUGUST G_DATE_BAD_MONTH G_DATE_BAD_WEEKDAY G_DATE_DAY G_DATE_DECEMBER G_DATE_FEBRUARY G_DATE_FRIDAY G_DATE_JANUARY G_DATE_JULY G_DATE_JUNE G_DATE_MARCH G_DATE_MAY G_DATE_MONDAY G_DATE_MONTH G_DATE_NOVEMBER G_DATE_OCTOBER G_DATE_SATURDAY G_DATE_SEPTEMBER G_DATE_SUNDAY G_DATE_THURSDAY G_DATE_TUESDAY G_DATE_WEDNESDAY G_DATE_YEAR G_ERR_DIGIT_RADIX G_ERR_FLOAT_RADIX G_ERR_NON_DIGIT_IN_CONST G_ERR_UNEXP_EOF G_ERR_UNEXP_EOF_IN_COMMENT G_ERR_UNEXP_EOF_IN_STRING G_ERR_UNKNOWN G_FILE_ERROR_ACCES G_FILE_ERROR_AGAIN G_FILE_ERROR_BADF G_FILE_ERROR_EXIST G_FILE_ERROR_FAULT G_FILE_ERROR_INTR G_FILE_ERROR_INVAL G_FILE_ERROR_IO G_FILE_ERROR_ISDIR G_FILE_ERROR_LOOP G_FILE_ERROR_MFILE G_FILE_ERROR_NAMETOOLONG G_FILE_ERROR_NFILE G_FILE_ERROR_NODEV G_FILE_ERROR_NOENT G_FILE_ERROR_NOMEM G_FILE_ERROR_NOSPC G_FILE_ERROR_NOTDIR G_FILE_ERROR_NXIO G_FILE_ERROR_PERM G_FILE_ERROR_PIPE G_FILE_ERROR_ROFS G_FILE_ERROR_TXTBSY G_FILE_TEST_EXISTS G_FILE_TEST_IS_DIR G_FILE_TEST_IS_EXECUTABLE G_FILE_TEST_IS_REGULAR G_FILE_TEST_IS_SYMLINK G_HOOK_FLAG_ACTIVE G_HOOK_FLAG_IN_CALL G_HOOK_FLAG_MASK G_IN_ORDER G_IO_CHANNEL_ERROR_FBIG G_IO_CHANNEL_ERROR_INVAL G_IO_CHANNEL_ERROR_IO G_IO_CHANNEL_ERROR_ISDIR G_IO_CHANNEL_ERROR_NOSPC G_IO_CHANNEL_ERROR_NXIO G_IO_CHANNEL_ERROR_OVERFLOW G_IO_CHANNEL_ERROR_PIPE G_IO_ERROR_AGAIN G_IO_ERROR_INVAL G_IO_ERROR_NONE G_IO_FLAG_APPEND G_IO_FLAG_GET_MASK G_IO_FLAG_IS_READABLE G_IO_FLAG_IS_SEEKABLE G_IO_FLAG_IS_WRITEABLE G_IO_FLAG_MASK G_IO_FLAG_NONBLOCK G_IO_FLAG_SET_MASK G_IO_STATUS_EOF G_IO_STATUS_ERROR G_IO_STATUS_NORMAL G_LOG_FLAG_FATAL G_LOG_FLAG_RECURSION G_LOG_LEVEL_CRITICAL G_LOG_LEVEL_DEBUG G_LOG_LEVEL_ERROR G_LOG_LEVEL_INFO G_LOG_LEVEL_MASK G_LOG_LEVEL_MESSAGE G_LOG_LEVEL_WARNING G_MARKUP_DO_NOT_USE_THIS_UNSUPPORTED_FLAG G_MARKUP_ERROR_BAD_UTF8 G_MARKUP_ERROR_EMPTY G_MARKUP_ERROR_PARSE G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE G_MARKUP_ERROR_UNKNOWN_ELEMENT G_MODULE_BIND_LAZY G_MODULE_BIND_LOCAL G_MODULE_BIND_MASK G_NORMALIZE_ALL G_NORMALIZE_ALL_COMPOSE G_NORMALIZE_DEFAULT G_NORMALIZE_DEFAULT_COMPOSE G_NORMALIZE_NFC G_NORMALIZE_NFD G_NORMALIZE_NFKC G_NORMALIZE_NFKD G_ONCE_STATUS_NOTCALLED G_ONCE_STATUS_PROGRESS G_POST_ORDER G_PRE_ORDER G_SEEK_CUR G_SEEK_SET G_SHELL_ERROR_BAD_QUOTING G_SHELL_ERROR_EMPTY_STRING G_SPAWN_CHILD_INHERITS_STDIN G_SPAWN_DO_NOT_REAP_CHILD G_SPAWN_ERROR_2BIG G_SPAWN_ERROR_ACCES G_SPAWN_ERROR_CHDIR G_SPAWN_ERROR_FORK G_SPAWN_ERROR_INVAL G_SPAWN_ERROR_IO G_SPAWN_ERROR_ISDIR G_SPAWN_ERROR_LIBBAD G_SPAWN_ERROR_LOOP G_SPAWN_ERROR_MFILE G_SPAWN_ERROR_NAMETOOLONG G_SPAWN_ERROR_NFILE G_SPAWN_ERROR_NOENT G_SPAWN_ERROR_NOEXEC G_SPAWN_ERROR_NOMEM G_SPAWN_ERROR_NOTDIR G_SPAWN_ERROR_PERM G_SPAWN_ERROR_READ G_SPAWN_ERROR_TXTBUSY G_SPAWN_FILE_AND_ARGV_ZERO G_SPAWN_LEAVE_DESCRIPTORS_OPEN G_SPAWN_SEARCH_PATH G_SPAWN_STDERR_TO_DEV_NULL G_SPAWN_STDOUT_TO_DEV_NULL G_THREAD_PRIORITY_HIGH G_THREAD_PRIORITY_LOW G_THREAD_PRIORITY_NORMAL G_TOKEN_BINARY G_TOKEN_CHAR G_TOKEN_COMMA G_TOKEN_COMMENT_MULTI G_TOKEN_COMMENT_SINGLE G_TOKEN_EOF G_TOKEN_EQUAL_SIGN G_TOKEN_ERROR G_TOKEN_FLOAT G_TOKEN_HEX G_TOKEN_IDENTIFIER G_TOKEN_IDENTIFIER_NULL G_TOKEN_INT G_TOKEN_LEFT_BRACE G_TOKEN_LEFT_CURLY G_TOKEN_LEFT_PAREN G_TOKEN_NONE G_TOKEN_OCTAL G_TOKEN_RIGHT_BRACE G_TOKEN_RIGHT_CURLY G_TOKEN_RIGHT_PAREN G_TOKEN_STRING G_TOKEN_SYMBOL G_TRAVERSE_ALL G_TRAVERSE_LEAFS G_TRAVERSE_MASK G_TRAVERSE_NON_LEAFS G_UNICODE_BREAK_AFTER G_UNICODE_BREAK_ALPHABETIC G_UNICODE_BREAK_AMBIGUOUS G_UNICODE_BREAK_BEFORE G_UNICODE_BREAK_BEFORE_AND_AFTER G_UNICODE_BREAK_CARRIAGE_RETURN G_UNICODE_BREAK_CLOSE_PUNCTUATION G_UNICODE_BREAK_COMBINING_MARK G_UNICODE_BREAK_COMPLEX_CONTEXT G_UNICODE_BREAK_CONTINGENT G_UNICODE_BREAK_EXCLAMATION G_UNICODE_BREAK_HYPHEN G_UNICODE_BREAK_IDEOGRAPHIC G_UNICODE_BREAK_INFIX_SEPARATOR G_UNICODE_BREAK_INSEPARABLE G_UNICODE_BREAK_LINE_FEED G_UNICODE_BREAK_MANDATORY G_UNICODE_BREAK_NEXT_LINE G_UNICODE_BREAK_NON_BREAKING_GLUE G_UNICODE_BREAK_NON_STARTER G_UNICODE_BREAK_NUMERIC G_UNICODE_BREAK_OPEN_PUNCTUATION G_UNICODE_BREAK_POSTFIX G_UNICODE_BREAK_PREFIX G_UNICODE_BREAK_QUOTATION G_UNICODE_BREAK_SPACE G_UNICODE_BREAK_SURROGATE G_UNICODE_BREAK_SYMBOL G_UNICODE_BREAK_UNKNOWN G_UNICODE_BREAK_ZERO_WIDTH_SPACE G_UNICODE_CLOSE_PUNCTUATION G_UNICODE_COMBINING_MARK G_UNICODE_CONNECT_PUNCTUATION G_UNICODE_CONTROL G_UNICODE_CURRENCY_SYMBOL G_UNICODE_DASH_PUNCTUATION G_UNICODE_DECIMAL_NUMBER G_UNICODE_ENCLOSING_MARK G_UNICODE_FINAL_PUNCTUATION G_UNICODE_FORMAT G_UNICODE_INITIAL_PUNCTUATION G_UNICODE_LETTER_NUMBER G_UNICODE_LINE_SEPARATOR G_UNICODE_LOWERCASE_LETTER G_UNICODE_MATH_SYMBOL G_UNICODE_MODIFIER_LETTER G_UNICODE_MODIFIER_SYMBOL G_UNICODE_NON_SPACING_MARK G_UNICODE_OPEN_PUNCTUATION G_UNICODE_OTHER_LETTER G_UNICODE_OTHER_NUMBER G_UNICODE_OTHER_PUNCTUATION G_UNICODE_OTHER_SYMBOL G_UNICODE_PARAGRAPH_SEPARATOR G_UNICODE_PRIVATE_USE G_UNICODE_SURROGATE G_UNICODE_TITLECASE_LETTER G_UNICODE_UNASSIGNED G_UNICODE_UPPERCASE_LETTER
syn keyword glibStruct GAllocator GArray GAsyncQueue GByteArray GCache GCompletion GCond GData GDate GDebugKey GDir GError GHashTable GHook GHookList GIOChannel GIOFuncs GList GMainContext GMainLoop GMarkupParseContext GMarkupParser GMemChunk GMemVTable GModule GMutex GNode GOnce GPatternSpec GPollFD GPrivate GPtrArray GQueue GRand GRelation GSList GScanner GScannerConfig GSource GSourceCallbackFuncs GSourceFuncs GStaticMutex GStaticPrivate GStaticRWLock GStaticRecMutex GString GStringChunk GThread GThreadFunctions GThreadPool GTimeVal GTimer GTrashStack GTree GTuples
syn keyword glibMacro ABS ATEXIT CLAMP GINT16_FROM_BE GINT16_FROM_LE GINT16_TO_BE GINT16_TO_LE GINT32_FROM_BE GINT32_FROM_LE GINT32_TO_BE GINT32_TO_LE GINT64_FROM_BE GINT64_FROM_LE GINT64_TO_BE GINT64_TO_LE GINT_FROM_BE GINT_FROM_LE GINT_TO_BE GINT_TO_LE GINT_TO_POINTER GLIB_CHECK_VERSION GLONG_FROM_BE GLONG_FROM_LE GLONG_TO_BE GLONG_TO_LE GPOINTER_TO_INT GPOINTER_TO_SIZE GPOINTER_TO_UINT GSIZE_TO_POINTER GUINT16_FROM_BE GUINT16_FROM_LE GUINT16_SWAP_BE_PDP GUINT16_SWAP_LE_BE GUINT16_SWAP_LE_BE_CONSTANT GUINT16_SWAP_LE_BE_IA32 GUINT16_SWAP_LE_BE_IA64 GUINT16_SWAP_LE_PDP GUINT16_TO_BE GUINT16_TO_LE GUINT32_FROM_BE GUINT32_FROM_LE GUINT32_SWAP_BE_PDP GUINT32_SWAP_LE_BE GUINT32_SWAP_LE_BE_CONSTANT GUINT32_SWAP_LE_BE_IA32 GUINT32_SWAP_LE_BE_IA64 GUINT32_SWAP_LE_BE_X86_64 GUINT32_SWAP_LE_PDP GUINT32_TO_BE GUINT32_TO_LE GUINT64_FROM_BE GUINT64_FROM_LE GUINT64_SWAP_LE_BE GUINT64_SWAP_LE_BE_CONSTANT GUINT64_SWAP_LE_BE_IA32 GUINT64_SWAP_LE_BE_IA64 GUINT64_SWAP_LE_BE_X86_64 GUINT64_TO_BE GUINT64_TO_LE GUINT_FROM_BE GUINT_FROM_LE GUINT_TO_BE GUINT_TO_LE GUINT_TO_POINTER GULONG_FROM_BE GULONG_FROM_LE GULONG_TO_BE GULONG_TO_LE G_BREAKPOINT G_GINT64_CONSTANT G_GNUC_FORMAT G_GNUC_PRINTF G_GNUC_SCANF G_HOOK G_HOOK_ACTIVE G_HOOK_FLAGS G_HOOK_IN_CALL G_HOOK_IS_UNLINKED G_HOOK_IS_VALID G_LIKELY G_LOCK G_LOCK_DEFINE G_LOCK_DEFINE_STATIC G_LOCK_EXTERN G_LOCK_NAME G_NODE_IS_LEAF G_NODE_IS_ROOT G_N_ELEMENTS G_STRINGIFY G_STRINGIFY_ARG G_STRUCT_MEMBER G_STRUCT_MEMBER_P G_STRUCT_OFFSET G_THREAD_CF G_THREAD_ECF G_THREAD_UF G_TRYLOCK G_UNLIKELY G_UNLOCK G_VA_COPY G_WIN32_DLLMAIN_FOR_DLL_NAME MAX MIN N_ Q_ alloca bindtextdomain dcgettext dgettext ftruncate g_ATEXIT g_alloca g_array_append_val g_array_index g_array_insert_val g_array_prepend_val g_ascii_isalnum g_ascii_isalpha g_ascii_iscntrl g_ascii_isdigit g_ascii_isgraph g_ascii_islower g_ascii_isprint g_ascii_ispunct g_ascii_isspace g_ascii_isupper g_ascii_isxdigit g_assert g_assert_not_reached g_atomic_int_dec_and_test g_atomic_int_get g_atomic_int_inc g_atomic_pointer_get g_chunk_free g_chunk_new g_chunk_new0 g_cond_broadcast g_cond_free g_cond_new g_cond_signal g_cond_timed_wait g_cond_wait g_critical g_datalist_get_data g_datalist_id_remove_data g_datalist_id_set_data g_datalist_remove_data g_datalist_remove_no_notify g_datalist_set_data g_datalist_set_data_full g_dataset_get_data g_dataset_id_remove_data g_dataset_id_set_data g_dataset_remove_data g_dataset_remove_no_notify g_dataset_set_data g_dataset_set_data_full g_error g_hook_append g_htonl g_htons g_list_next g_list_previous g_mem_chunk_create g_memmove g_message g_mutex_free g_mutex_lock g_mutex_new g_mutex_trylock g_mutex_unlock g_new g_new0 g_newa g_node_append g_node_append_data g_node_first_child g_node_insert_data g_node_insert_data_before g_node_next_sibling g_node_prepend_data g_node_prev_sibling g_ntohl g_ntohs g_once g_private_get g_private_new g_private_set g_ptr_array_index g_rand_boolean g_random_boolean g_renew g_return_if_fail g_return_if_reached g_return_val_if_fail g_return_val_if_reached g_slist_next g_static_mutex_get_mutex g_static_mutex_get_mutex_impl_shortcut g_static_mutex_lock g_static_mutex_trylock g_static_mutex_unlock g_string_append_c g_strstrip g_thread_create g_thread_init g_thread_supported g_thread_yield g_utf8_next_char g_warning gettext pipe textdomain
syn keyword glibEnum GAsciiType GConvertError GDateDMY GDateMonth GDateWeekday GErrorType GFileError GFileTest GHookFlagMask GIOChannelError GIOCondition GIOError GIOFlags GIOStatus GLogLevelFlags GMarkupError GMarkupParseFlags GModuleFlags GNormalizeMode GOnceStatus GSeekType GShellError GSpawnError GSpawnFlags GThreadError GThreadPriority GTokenType GTraverseFlags GTraverseType GUnicodeBreakType GUnicodeType
syn keyword glibUserFunction GCacheDestroyFunc GCacheDupFunc GCacheNewFunc GChildWatchFunc GCompareDataFunc GCompareFunc GCompletionFunc GCompletionStrncmpFunc GCopyFunc GDataForeachFunc GDestroyNotify GEqualFunc GFreeFunc GFunc GHFunc GHRFunc GHashFunc GHookCheckFunc GHookCheckMarshaller GHookCompareFunc GHookFinalizeFunc GHookFindFunc GHookFunc GHookMarshaller GIOFunc GLogFunc GModuleCheckInit GModuleUnload GNodeForeachFunc GNodeTraverseFunc GPollFunc GPrintFunc GScannerMsgFunc GSourceDummyMarshal GSourceFunc GSpawnChildSetupFunc GThreadFunc GTraverseFunc GVoidFunc
syn keyword glibDefine FALSE GLIB_HAVE_ALLOCA_H GLIB_HAVE_SYS_POLL_H GLIB_MAJOR_VERSION GLIB_MICRO_VERSION GLIB_MINOR_VERSION GLIB_SIZEOF_LONG GLIB_SIZEOF_SIZE_T GLIB_SIZEOF_VOID_P GLIB_SYSDEF_POLLERR GLIB_SYSDEF_POLLHUP GLIB_SYSDEF_POLLIN GLIB_SYSDEF_POLLNVAL GLIB_SYSDEF_POLLOUT GLIB_SYSDEF_POLLPRI GLIB_VAR G_ALLOCATOR_LIST G_ALLOCATOR_NODE G_ALLOCATOR_SLIST G_ALLOC_AND_FREE G_ALLOC_ONLY G_ASCII_DTOSTR_BUF_SIZE G_BEGIN_DECLS G_BIG_ENDIAN G_BYTE_ORDER G_CAN_INLINE G_CONST_RETURN G_CONVERT_ERROR G_CSET_A_2_Z G_CSET_DIGITS G_CSET_LATINC G_CSET_LATINS G_CSET_a_2_z G_DATE_BAD_DAY G_DATE_BAD_JULIAN G_DATE_BAD_YEAR G_DIR_SEPARATOR G_DIR_SEPARATOR_S G_E G_END_DECLS G_FILE_ERROR G_GINT16_FORMAT G_GINT16_MODIFIER G_GINT32_FORMAT G_GINT32_MODIFIER G_GINT64_FORMAT G_GINT64_MODIFIER G_GNUC_CONST G_GNUC_DEPRECATED G_GNUC_EXTENSION G_GNUC_FUNCTION G_GNUC_NORETURN G_GNUC_NO_INSTRUMENT G_GNUC_PRETTY_FUNCTION G_GNUC_PURE G_GNUC_UNUSED G_GSIZE_FORMAT G_GSIZE_MODIFIER G_GSSIZE_FORMAT G_GUINT16_FORMAT G_GUINT32_FORMAT G_GUINT64_FORMAT G_HAVE_GINT64 G_HAVE_GNUC_VARARGS G_HAVE_GROWING_STACK G_HAVE_INLINE G_HAVE_ISO_VARARGS G_HAVE___INLINE G_HAVE___INLINE__ G_HOOK_FLAG_USER_SHIFT G_IEEE754_DOUBLE_BIAS G_IEEE754_FLOAT_BIAS G_INLINE_FUNC G_IO_CHANNEL_ERROR G_LITTLE_ENDIAN G_LN10 G_LN2 G_LOG_2_BASE_10 G_LOG_DOMAIN G_LOG_FATAL_MASK G_LOG_LEVEL_USER_SHIFT G_MARKUP_ERROR G_MAXDOUBLE G_MAXFLOAT G_MAXINT G_MAXINT16 G_MAXINT32 G_MAXINT64 G_MAXINT8 G_MAXLONG G_MAXSHORT G_MAXSIZE G_MAXUINT G_MAXUINT16 G_MAXUINT32 G_MAXUINT64 G_MAXUINT8 G_MAXULONG G_MAXUSHORT G_MEM_ALIGN G_MINDOUBLE G_MINFLOAT G_MININT G_MININT16 G_MININT32 G_MININT64 G_MININT8 G_MINLONG G_MINSHORT G_MODULE_EXPORT G_MODULE_IMPORT G_MODULE_SUFFIX G_MUTEX_DEBUG_MAGIC G_NATIVE_ATEXIT G_ONCE_INIT G_OS_UNIX G_PDP_ENDIAN G_PI G_PI_2 G_PI_4 G_PRIORITY_DEFAULT G_PRIORITY_DEFAULT_IDLE G_PRIORITY_HIGH G_PRIORITY_HIGH_IDLE G_PRIORITY_LOW G_SEARCHPATH_SEPARATOR G_SEARCHPATH_SEPARATOR_S G_SHELL_ERROR G_SPAWN_ERROR G_SQRT2 G_STATIC_MUTEX_INIT G_STATIC_PRIVATE_INIT G_STATIC_REC_MUTEX_INIT G_STATIC_RW_LOCK_INIT G_STMT_END G_STMT_START G_STRFUNC G_STRLOC G_STR_DELIMITERS G_THREADS_ENABLED G_THREADS_IMPL_POSIX G_THREAD_ERROR G_USEC_PER_SEC G_VA_COPY G_WIN32_MSG_HANDLE MAXPATHLEN NULL TRUE alloca inline
if exists("glib_enable_deprecated")
syn keyword glibFunction g_async_queue_ref_unlocked g_async_queue_unref_and_unlock g_basename g_io_channel_close g_io_channel_read g_io_channel_seek g_io_channel_write g_strcasecmp g_strdown g_string_down g_string_up g_strncasecmp g_strup g_tree_traverse
syn keyword glibMacro g_date_day g_date_day_of_year g_date_days_in_month g_date_julian g_date_monday_week_of_year g_date_monday_weeks_in_year g_date_month g_date_sunday_week_of_year g_date_sunday_weeks_in_year g_date_weekday g_date_year g_dirname g_hash_table_freeze g_hash_table_thaw g_main_destroy g_main_is_running g_main_iteration g_main_new g_main_pending g_main_quit g_main_run g_main_set_poll_func g_scanner_add_symbol g_scanner_foreach_symbol g_scanner_freeze_symbol_table g_scanner_remove_symbol g_scanner_thaw_symbol_table g_string_sprintf g_string_sprintfa
endif

" Default highlighting
if version >= 508 || !exists("did_glib_syntax_inits")
  if version < 508
    let did_glib_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink glibFunction Function
  HiLink glibTypedef Type
  HiLink glibConstant Constant
  HiLink glibStruct Type
  HiLink glibMacro Macro
  HiLink glibEnum Type
  HiLink glibUserFunction Type
  HiLink glibDefine Constant
  delcommand HiLink
endif

