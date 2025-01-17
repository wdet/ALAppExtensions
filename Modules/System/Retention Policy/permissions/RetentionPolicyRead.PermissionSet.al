// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

PermissionSet 3900 "Retention Policy - Read"
{
    Access = Internal;
    Assignable = false;

    IncludedPermissionSets = "Field Selection - Read",
                             "Guided Experience - Read",
                             "Object Selection - Read",
                             "Upgrade Tags - Read",
                             "System Initialization - Exec";

    Permissions = tabledata AllObj = r,
                  tabledata AllObjWithCaption = r,
                  tabledata Permission = r,
                  tabledata "Published Application" = r,
                  tabledata "Retention Period" = R,
                  tabledata "Retention Policy Allowed Table" = r,
                  tabledata "Retention Policy Log Entry" = r,
                  tabledata "Retention Policy Setup" = R,
                  tabledata "Retention Policy Setup Line" = R,
                  tabledata "Tenant Permission" = r,
                  tabledata User = r,
                  tabledata "Access Control" = r,
                  tabledata Company = r,
                  tabledata Field = r;
}
