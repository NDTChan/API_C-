﻿define([], function () {
    'use strict';
    var app = angular.module('phf_dmDoiTuong', []);
    var listDotThanhTra = [];
    app.factory('DmDoiTuongService', ['$http', 'configService', function ($http, configService) {
        var serviceUrl = configService.rootUrlWebApi + '/dm/phf_dmDoiTuong';
        var result = {
            paging: function (data) {
                return $http.post(serviceUrl + '/Paging', data);
            },
            post: function (data) {
                return $http.post(serviceUrl + '/Post', data);
            },
            getItem: function (id) {
                return $http.get(serviceUrl + '/' + id);
            },
            update: function (params) {
                return $http.put(serviceUrl + '/' + params.Id, params);
            },
            deleteItem: function (params) {
                return $http.delete(serviceUrl + '/' + params.Id, params);
            },
            getSelectData: function () {
                return $http.get(serviceUrl + '/GetSelectData');
            },
            Export: function (data) {
                return $http.post(serviceUrl + '/Export', data, { responseType: 'arraybuffer' });
            },
            CheckCodeExist: function (Id) {
                return $http.get(serviceUrl + '/CheckCodeExist/' + Id);
            },
            GetDataDetailByYear: function (year) {
                return $http.get(serviceUrl + '/GetDataDetailByYear/' + year);
            }
        }
        return result;
    }]);

    app.controller('DmDoiTuongCtrl', ['$scope', '$location', 'DmDoiTuongService', 'configService', '$state', 'tempDataService', '$filter', '$uibModal', '$log', 'securityService', 'toaster', 'ngNotify',
        function ($scope, $location, service, configService, $state, tempDataService, $filter, $uibModal, $log, securityService, toaster, ngNotify) {

            $scope.paged = angular.copy(configService.pageDefault);
            $scope.filtered = angular.copy(configService.filterDefault);
            $scope.tempData = tempDataService.tempData;
            $scope.config = angular.copy(configService);

            $scope.accessList = {};
            function filterData() {
                if ($scope.accessList.View) {
                    var postdata = { paged: $scope.paged, filtered: $scope.filtered };
                    service.paging(postdata).then(function (successRes) {
                        if (successRes && successRes.status == 200 && successRes.data && !successRes.data.Error) {
                            $scope.data = successRes.data.Data.Data;
                            $scope.paged.totalItems = successRes.data.Data.totalItems;

                        } else {
                            $scope.data = [];
                            $scope.paged.totalItems = 0;
                            toaster.pop('error', "Lỗi:", successRes.data.Message);
                        }
                    }, function (errorRes) {
                        toaster.pop('error', "Lỗi:", errorRes.statusText);
                    });
                }
            };

            function loadAccessList() {
                securityService.getAccessList('phf_dmDotThanhTra').then(function (successRes) {
                    if (successRes && successRes.status == 200) {
                        $scope.accessList = successRes.data;
                        if (!$scope.accessList.View) {
                            toaster.pop('error', "Lỗi:", "Không có quyền truy cập !");
                        } else {
                            filterData();
                        }
                    } else {
                        toaster.pop('error', "Lỗi:", "Không có quyền truy cập !");
                    }
                }, function (errorRes) {;
                    toaster.pop('error', "Lỗi:", "Không có quyền truy cập !");
                    $scope.accessList = null;
                });
            }
            loadAccessList();

            $scope.displayHepler = function (module, value) {
                var data = $filter('filter')($scope.tempData(module), { value: value }, true);
                if (data.length == 1) {
                    return data[0].text;
                } else {
                    return value;
                }
            }

            $scope.setPage = function (pageNo) {
                $scope.paged.currentPage = pageNo;
                filterData();
            };
            $scope.sortType = 'ID';

            $scope.sortReverse = false;

            $scope.doSearch = function () {
                $scope.paged.currentPage = 1;
                filterData();
            };

            $scope.pageChanged = function () {
                filterData();
            };

            $scope.goHome = function () {
                $state.go('home');
            };

            $scope.refresh = function () {
                $scope.setPage($scope.paged.currentPage);
            };

            $scope.create = function () {
                var modalInstance = $uibModal.open({
                    backdrop: 'static',
                    size: 'md',
                    templateUrl: configService.buildUrl('dm/phf_dmDoiTuong', 'add'),
                    controller: 'DmDoiTuongCreateCtrl',
                    resolve: {}
                });
                modalInstance.result.then(function (updatedData) {
                    $scope.refresh();
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };

            $scope.edit = function (target) {
                var modalInstance = $uibModal.open({
                    backdrop: 'static',
                    templateUrl: configService.buildUrl('dm/phf_dmDoiTuong', 'edit'),
                    controller: 'DmDoiTuongEditCtrl',
                    resolve: {
                        targetData: function () {
                            return target;
                        }
                    }
                });
                console.log(target);
                modalInstance.result.then(function (updatedData) {
                    var index = $scope.data.indexOf(target);
                    if (index !== -1) {
                        $scope.data[index] = updatedData;

                    }
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };
            $scope.detail = function (target) {
                var modalInstance = $uibModal.open({
                    backdrop: 'static',
                    templateUrl: configService.buildUrl('dm/phf_dmDoiTuong', 'detail'),
                    controller: 'DmDoiTuongDetailCtrl',
                    resolve: {
                        targetData: function () {
                            return target;
                        }
                    }
                });
                modalInstance.result.then(function (updatedData) {
                    var index = $scope.data.indexOf(target);
                    if (index !== -1) {
                        $scope.data[index] = updatedData;
                    }
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };

            $scope.delete = function (target) {
                var modalInstance = $uibModal.open({
                    backdrop: 'static',
                    templateUrl: configService.buildUrl('dm/phf_dmDoiTuong', 'delete'),
                    controller: 'DmDoiTuongDeleteCtrl',
                    resolve: {
                        targetData: function () {
                            return target;
                        }
                    }
                });
                modalInstance.result.then(function (updatedData) {
                    var index = $scope.data.indexOf(target);
                    if (index !== -1) {
                        $scope.data.splice(index, 1);
                    }
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };

            function SaveFile(name, type, data) {
                var ieEDGE = navigator.userAgent.match(/Edge/g);
                var ie = navigator.userAgent.match(/.NET/g); // IE 11+
                var oldIE = navigator.userAgent.match(/MSIE/g);
                if (ie || oldIE || ieEDGE) {
                    var blob = new window.Blob([data], { type: type });
                    window.navigator.msSaveBlob(blob, name);
                }
                else {
                    var a = $("<a style='display: none;'/>");
                    var url = window.URL.createObjectURL(new Blob([data], { type: type }));
                    a.attr("href", url);
                    a.attr("download", name);
                    $("body").append(a);
                    a[0].click();
                    window.URL.revokeObjectURL(url);
                    a.remove();
                }
            }

            $scope.export = function () {
                $scope.isLoading = true;
                service.Export().then(function (successRes) {
                    if (successRes && successRes.status === 200 && successRes.data) {
                        $scope.isLoading = false;
                        var date = new Date();
                        var tmp = date.getDate() + '-' + (date.getMonth() + 1) + '-' + date.getFullYear();
                        SaveFile('Export_DM_DoiTuong_(' + tmp + ').xls', 'application/vnd.ms-excel', successRes.data);
                        ngNotify.set('Xuất file thành công !', { duration: 3000, type: 'success' });
                    }
                }, function (errorRes) {
                    ngNotify.set('Lỗi: ' + errorRes, { duration: 3000, type: 'error' });
                });
            }
        }]);

    app.controller('DmDoiTuongCreateCtrl', ['$scope', '$uibModalInstance', '$location', 'DmDoiTuongService', 'configService', '$state', 'tempDataService', '$filter', '$uibModal', '$log', 'ngNotify',
        function ($scope, $uibModalInstance, $location, service, configService, $state, tempDataService, $filter, $uibModal, $log, ngNotify) {
            $scope.config = angular.copy(configService);
            $scope.tempData = tempDataService.tempData;
            $scope.target = {};
            $scope.isLoading = false;
            $scope.target.TRANG_THAI = "1";

            $scope.title = function () { return '	Thêm mới đối tượng'; };

            $scope.CheckExist = function (MA_DOITUONG) {
                if (MA_DOITUONG) {
                    service.CheckCodeExist(MA_DOITUONG).then(function (response) {
                        if (response && response.status == 200 && !response.data.Error) {
                            if (response.data.Data != null) {
                                document.getElementById("MA_DOITUONG").focus();
                                $scope.target.MA_DOITUONG = '';
                                ngNotify.set(" Mã đối tượng " + MA_DOITUONG + " đã tồn tại ", { type: 'error' });
                            }
                            else {

                            }
                        }
                    });
                }
            };

            $scope.save = function () {

                service.post($scope.target).then(function (successRes) {
                    if (successRes && successRes.status === 200 && !successRes.data.Error) {
                        ngNotify.set(successRes.data.Message, { type: 'success' });
                        $uibModalInstance.close($scope.target);
                    } else {
                        console.log('successRes', successRes);
                        ngNotify.set(successRes.data.Message, { duration: 3000, type: 'error' });
                    }
                }, function (errorRes) { });
            };
            $scope.cancel = function () {
                $uibModalInstance.close();
            };
        }]);

    app.controller('DmDoiTuongEditCtrl', ['$scope', '$uibModalInstance', '$location', 'DmDoiTuongService', 'configService', '$state', 'tempDataService', '$filter', '$uibModal', '$log', 'targetData', 'ngNotify',
        function ($scope, $uibModalInstance, $location, service, configService, $state, tempDataService, $filter, $uibModal, $log, targetData, ngNotify) {
            $scope.target = targetData;
            $scope.config = angular.copy(configService);
            $scope.targetData = angular.copy(targetData);
            $scope.tempData = tempDataService.tempData;

            $scope.isLoading = false;

            $scope.title = function () { return 'Cập nhật đối tượng'; };

            $scope.save = function () {
                service.update($scope.target).then(function (successRes) {
                    if (successRes && successRes.status == 200 && !successRes.data.Error) {
                        ngNotify.set(successRes.data.Message, { type: 'success' });
                        $uibModalInstance.close($scope.target);
                    } else {
                        console.log('successRes', successRes);
                        ngNotify.set(successRes.data.Message, { duration: 3000, type: 'error' });
                    }
                },
                function (errorRes) {
                    console.log('errorRes', errorRes);
                });
            };
            $scope.cancel = function () {
                $uibModalInstance.dismiss('cancel');
            };
        }]);

    app.controller('DmDoiTuongDetailCtrl', ['$scope', '$uibModalInstance', '$location', 'DmDoiTuongService', 'configService', '$state', 'tempDataService', '$filter', '$uibModal', '$log', 'targetData',
	function ($scope, $uibModalInstance, $location, service, configService, $state, tempDataService, $filter, $uibModal, $log, targetData) {
	    $scope.tempData = tempDataService.tempData;
	    $scope.config = tempDataService.config;
	    $scope.target = targetData;
	    $scope.config = angular.copy(configService);

	    $scope.title = function () { return 'Chi tiết đối tượng'; };

	    $scope.cancel = function () {
	        $uibModalInstance.dismiss('cancel');
	    };
	}]);

    app.controller('DmDoiTuongDeleteCtrl', ['$scope', '$uibModalInstance', '$location', 'DmDoiTuongService', 'configService', '$state', 'tempDataService', '$filter', '$uibModal', '$log', 'targetData', 'ngNotify',
        function ($scope, $uibModalInstance, $location, service, configService, $state, tempDataService, $filter, $uibModal, $log, targetData, ngNotify) {
            $scope.target = targetData;
            $scope.config = angular.copy(configService);
            $scope.targetData = angular.copy(targetData);
            $scope.isLoading = false;

            $scope.title = function () { return 'Xóa đối tượng'; };

            $scope.save = function () {
                service.deleteItem($scope.target).then(function (successRes) {
                    if (successRes && successRes.status == 200 && !successRes.data.Error) {
                        ngNotify.set(successRes.data.Message, { type: 'success' });
                        $uibModalInstance.close($scope.target);
                    } else {
                        console.log('successRes', successRes);
                        ngNotify.set(successRes.data.Message, { duration: 3000, type: 'error' });
                    }
                },
                    function (errorRes) {
                        console.log('errorRes', errorRes);
                    });
            };
            $scope.close = function () {
                $uibModalInstance.dismiss('cancel');
            };
        }]);

    return app;
});


