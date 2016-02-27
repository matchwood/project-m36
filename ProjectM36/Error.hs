{-# LANGUAGE DeriveGeneric, DeriveAnyClass #-}
module ProjectM36.Error where
import ProjectM36.Base
import qualified Data.Set as S
import qualified Data.UUID as U
import Control.DeepSeq (NFData, rnf)
import Control.DeepSeq.Generics (genericRnf)
import GHC.Generics (Generic)
import qualified Data.Text as T
import Data.Binary
import Data.Typeable

data RelationalError = NoSuchAttributeNamesError (S.Set AttributeName)
                     | TupleAttributeCountMismatchError Int --attribute name
                     | TupleAttributeTypeMismatchError Attributes
                     | AttributeCountMismatchError Int
                     | AttributeNamesMismatchError (S.Set AttributeName)
                     | AttributeNameInUseError AttributeName
                     | AttributeIsNotRelationValuedError AttributeName
                     | CouldNotInferAttributes
                     | RelVarNotDefinedError RelVarName
                     | RelVarAlreadyDefinedError RelVarName
                     | RelVarAssignmentTypeMismatchError Attributes Attributes --expected, found
                     | InclusionDependencyCheckError IncDepName
                     | InclusionDependencyNameInUseError IncDepName
                     | InclusionDependencyNameNotInUseError IncDepName
                     | ParseError T.Text
                     | PredicateExpressionError T.Text
                     | NoSuchTransactionError U.UUID
                     | NoSuchHeadNameError HeadName
                     | TransactionIsNotAHeadError U.UUID
                     | TransactionGraphCycleError U.UUID
                     | SessionIdInUseError U.UUID
                     | NoSuchSessionError U.UUID
                     | NoSuchTupleExprFunctionError AtomFunctionName
                     | NoSuchTypeConstructorName TypeConstructorName
                     | AtomTypeMismatchError AtomType AtomType
                     | TypeConstructorNameMismatch TypeConstructorName TypeConstructorName
                     | AtomTypeTypeConstructorReconciliationError AtomType TypeConstructor
                     | DataConstructorNameInUseError DataConstructorName
                     | DataConstructorUsesUndeclaredTypeVariable TypeConstructorPolymorphicName
                     | AtomTypeNameInUseError AtomTypeName
                     | IncompletelyDefinedAtomTypeWithConstructorError
                     | AtomTypeNameNotInUseError AtomTypeName
                     | NoSuchDataConstructorError DataConstructorName
                     | NoSuchTypeConstructorError TypeConstructorName
                     | InvalidAtomTypeName AtomTypeName
                     | AtomTypeNotSupported AttributeName --used by persistent driver
                     | AtomOperatorNotSupported T.Text --used by persistent driver
                     | EmptyTuplesError -- used by persistent driver
                     | AtomTypeCountError [AtomType] [AtomType]
                     | AtomFunctionTypeError AtomFunctionName Int AtomType AtomType --arg number
                     | RelationValuedAttributesNotSupportedError [AttributeName]
                     | NotificationNameInUseError NotificationName
                     | NotificationNameNotInUseError NotificationName
                     | ImportError T.Text -- really? This should be broken out into some other error type- this has nothing to do with relational algebra
                     | ExportError T.Text
                     | MultipleErrors [RelationalError]
                       deriving (Show,Eq,Generic,Binary,Typeable) 

instance NFData RelationalError where rnf = genericRnf
                                      
data PersistenceError = InvalidDirectoryError FilePath | 
                        MissingTransactionError U.UUID
                      deriving (Show, Eq)

                                      